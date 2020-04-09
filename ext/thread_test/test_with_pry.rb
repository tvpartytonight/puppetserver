require 'net/http'
require 'json'
require 'rspec/expectations'
require 'openssl'
require_relative 'stupidly_insecure'

require 'json'

iterations = 100
processes_per_catalog = 2
include RSpec::Matchers

SERVER_URL = "pe-infranext-test.infc-aws.puppet.net"
class CatalogTester
  def initialize
    @v4uri = URI("http://#{SERVER_URL}:8140/puppet/v4/catalog")
    @uri = URI("http://#{SERVER_URL}:8140/puppet/v3/catalog/#{@catalog}?environment=#{@environment}")
  end

  def run_v4
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.cert = OpenSSL::X509::Certificate.new(@cert)
    http.key = OpenSSL::PKey::RSA.new(@key)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    header = {'Content-Type': 'text/json'}
    request = Net::HTTP::Post.new(@uri.request_uri, header)
    body = { 'certname': @catalog,
             'persistence': {'facts': false, 'catalog': false,},
             'environment': @environment }
    if @facts
      body['facts'] = {'values': @facts}
    end
    request.body = body.to_json

    result = http.request(request)
    verify(result)
  end

  def run
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.cert = OpenSSL::X509::Certificate.new(@cert)
    http.key = OpenSSL::PKey::RSA.new(@key)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    if @facts
      header = {'Content-Type': 'text/json'}
      request = Net::HTTP::Post.new(@uri.request_uri, header)
      request.body = @facts
    else
      request = Net::HTTP::Get.new(@uri.request_uri)

    end
    result = http.request(request)
    verify(result)
  end

  def verify(result)
    expect(result.code).to eq("200"), "The response body is: #{result.body}"
  end
end

class CatalogOneTester < CatalogTester
  def initialize
    @cert = OpenSSL::X509::Certificate.new(COMPILER_CERT)
    @key = OpenSSL::PKey.read(COMPILER_PRIV_KEY)
    @catalog = 'pe-compiler-infranext-test-1.infc-aws.puppet.net'
    @environment = 'production'
    super
  end

  def verify(result)
    super
  end
end

class CatalogTwoTester < CatalogTester
  def initialize
    @cert = OpenSSL::X509::Certificate.new(WINDOWS_CERT)
    @key = OpenSSL::PKey.read(WINDOWS_PRIV_KEY)
    @catalog = 'sorry-undercut.delivery.puppetlabs.net'
    @environment = 'moar_connections'
    @facts = WINDOWS_FACTS
    super
  end

  def verify(result)
    super
  end
end

processes_per_catalog.times do
  Process.fork do
    tester = CatalogOneTester.new
    iterations.times do
      tester.run
      puts 'succesfully hit v3 endpoint for master compiler'
    end
  end
end

processes_per_catalog.times do
  Process.fork do
    tester = CatalogOneTester.new
    iterations.times do
      tester.run_v4
      puts 'succesfully hit v4 endpoint for master compiler'
    end
  end
end

processes_per_catalog.times do
  Process.fork do
    tester = CatalogTwoTester.new
    iterations.times do
      tester.run_v4
      puts 'succesfully hit v4 endpoint for windows'
    end
  end
end

processes_per_catalog.times do
  Process.fork do
    tester = CatalogTwoTester.new
    iterations.times do
      tester.run
      puts 'succesfully hit v3 endpoint for windows'
    end
  end
end

exit_codes = Process.waitall

if exit_codes.all? { |s| s[1].exitstatus.zero? }
  exit 0
else
  exit 1
end
