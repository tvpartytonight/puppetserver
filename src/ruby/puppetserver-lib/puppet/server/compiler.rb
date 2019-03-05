require 'puppet/server'
require 'puppet/server/log_collector'

module Puppet
  module Server
    class Compiler

      def initialize
        set_server_facts
      end

      # Compiles a catalog according to the spec provided from the
      # request.
      # @param [Hash] request_data details about the catalog to be compiled
      # @return [Hash] containing either just the catalog or catalog and logs,
      #                if capturing logs was enabled
      def compile(request_data)
        persist = processed_hash['persistence']
        options = request_data['options'] || {}

        if persist['facts']
          save_facts(node.facts, node.trusted_data)
        end

        if options['capture_logs']
          catalog, logs = capture_logs do
            compile_catalog(request_data)
          end
          save_catalog(catalog) if persist['catalog']
          { catalog: catalog, logs: logs }
        else
          catalog = compile_catalog(request_data)
          save_catalog(catalog) if persist['catalog']
          { catalog: catalog }
        end
      end

      private

      def save_facts(facts, trusted_facts)
          if Puppet::Node::Facts.indirection.terminus_class.to_s == "puppetdb"
            Puppet.override({trusted_information: trusted_facts}) do
              Puppet::Node::Facts.indirection.save(facts)
            end
          else
            raise Puppet::Error, "PuppetDB not configured, not saving Facts"
          end
        end

      def save_catalog(catalog)
        if Puppet::Resource::Catalog.indirection.cache_class.to_s == "puppetdb"
          Puppet::Resource::Catalog.indirection.save(catalog)
        else
          raise Puppet::Error, "PuppetDB not configured, not saving Catalog"
        end
      end

      def compile_catalog(request_data)
        node = create_node(request_data)
        catalog = Puppet::Parser::Compiler.compile(node, request_data['job_id'])
        catalog.to_data_hash
      end

      def capture_logs(&block)
        logs = []
        result = nil
        log_dest = Puppet::Server::LogCollector.new(logs)
        Puppet::Util::Log.with_destination(log_dest) do
          result = yield
        end

        log_entries = logs.map do |log|
          log.to_data_hash
        end.select do |log|
          # Filter out debug messages, which may be verbose and
          # contain sensitive data
          log['level'] == 'warning' || log['level'] == 'error'
        end

        return result, log_entries
      end

      def save_facts(facts, trusted_facts)
        Puppet.override({trusted_information: trusted_facts}) do
          Puppet::Node::Facts.indirection.save(facts)
        end
      end

      def save_catalog(catalog)
        Puppet::Resource::Catalog.indirection.save(catalog)
      end

      def create_node(request_data)
        # We need an environment to talk to PDB
        request_data['environment'] ||= 'production'

        facts, trusted_facts = process_facts(request_data)
        node_params = { facts: facts,
                        # TODO: fetch environment from classifier
                        environment: request_data['environment'],
                        # data added to the node object and exposed in manifests as
                        # top-level vars. Maybe related to class params??
                        # Can these also come from the classifier?
                        parameters: request_data['parameters'],
                        # TODO: fetch classes from classifier
                        classes: request_data['classes'] }

        node = Puppet::Node.new(request_data['certname'], node_params)
        # Merges facts into the node parameters.
        # Ensures that facts will be surfaced as top-scope variables,
        # along with other node parameters.
        node.merge(facts.values)
        node.trusted_data = trusted_facts
        node.add_server_facts(@server_facts)
        node
      end

      # @return Puppet::Node::Facts facts, Hash trusted_facts
      def process_facts(request_data)
        facts = extract_facts(request_data)
        trusted_facts = extract_trusted_facts(request_data, facts)

        return facts, trusted_facts
      end

      def extract_facts(request_data)
        if request_data['facts'].nil?
          if Puppet::Node::Facts.indirection.terminus.to_s == "puppetdb"
            facts = get_facts_from_pdb(request_data['certname'], request_data['environment'])
          else
            raise(Puppet::Error, "PuppetDB not configured, please provide facts with your catalog request.")
          end
        else
          facts_from_request = request_data['facts']

          # Ensure request data has the proper keys, mirroring the structure
          # of Facts#to_data_hash
          facts_from_request['values'] ||= {}
          facts_from_request['name'] ||= request_data['certname']

          facts = Puppet::Node::Facts.from_data_hash(facts_from_request)
        end

        facts.sanitize

        facts
      end

      def extract_trusted_facts(request_data, facts)
        # Pull the trusted facts from the request, or attempt to extract them from
        # the facts hash
        trusted_facts = if request_data['trusted_facts']
                          request_data['trusted_facts']['values']
                        else
                          fact_values = facts.to_data_hash['values']
                          fact_values['trusted']
                        end
        # If no trusted facts could be found, ensure a hash is returned
        trusted_facts ||= {}
      end

      def get_facts_from_pdb(nodename, environment)
        pdb_terminus = Puppet::Node::Facts::Puppetdb.new
        request = Puppet::Indirector::Request.new(pdb_terminus.class.name,
                                                  :find,
                                                  nodename,
                                                  nil,
                                                  :environment => environment)
        facts = pdb_terminus.find(request)

        # If no facts have been stored for the node, PDB will return nil
        if facts.nil?
          # Create an empty facts object
          facts = Puppet::Node::Facts.new(nodename)
        end

        facts
      end

      # Initialize our server fact hash; we add these to each catalog, and they
      # won't change while we're running, so it's safe to cache the values.
      #
      # This is lifted directly from Puppet::Indirector::Catalog::Compiler.
      def set_server_facts
        @server_facts = {}

        # Add our server version to the fact list
        @server_facts['serverversion'] = Puppet.version.to_s

        # And then add the server name and IP
        { 'servername' => 'fqdn',
          'serverip' => 'ipaddress'
        }.each do |var, fact|
          if value = Facter.value(fact)
            @server_facts[var] = value
          else
            Puppet.warning "Could not retrieve fact #{fact}"
          end
        end

        if @server_facts['servername'].nil?
          host = Facter.value(:hostname)
          if domain = Facter.value(:domain)
            @server_facts['servername'] = [host, domain].join('.')
          else
            @server_facts['servername'] = host
          end
        end
      end
    end
  end
end
