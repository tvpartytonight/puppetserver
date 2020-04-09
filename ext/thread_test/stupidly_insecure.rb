COMPILER_PRIV_KEY = "-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----"

COMPILER_CERT = "-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----"


WINDOWS_FACTS = <<-WINFACTS
{
  "aio_agent_version": "6.14.0",
  "dmi": {
    "manufacturer": "VMware, Inc.",
    "product": {
      "name": "VMware7,1",
      "serial_number": "VMware-42 1a 01 ed 7f e1 62 33-56 d5 17 08 14 6a 47 4a",
      "uuid": "ED011A42-E17F-3362-56D5-1708146A474A"
    }
  },
  "env_windows_installdir": "C:\\Program Files\\Puppet Labs\\Puppet",
  "facterversion": "3.14.9",
  "fips_enabled": false,
  "hypervisors": {
    "vmware": {}
  },
  "identity": {
    "privileged": true,
    "user": "SORRY-UNDERCUT\\Administrator"
  },
  "is_virtual": true,
  "kernel": "windows",
  "kernelmajversion": "10.0",
  "kernelrelease": "10.0.17763",
  "kernelversion": "10.0.17763",
  "memory": {
    "system": {
      "available": "2.44 GiB",
      "available_bytes": 2619256832,
      "capacity": "39.00%",
      "total": "4.00 GiB",
      "total_bytes": 4293898240,
      "used": "1.56 GiB",
      "used_bytes": 1674641408
    }
  },
  "networking": {
    "dhcp": "10.32.22.9",
    "domain": "delivery.puppetlabs.net",
    "fqdn": "sorry-undercut.delivery.puppetlabs.net",
    "hostname": "sorry-undercut",
    "interfaces": {
      "Ethernet0": {
        "bindings": [
          {
            "address": "10.16.113.27",
            "netmask": "255.255.240.0",
            "network": "10.16.112.0"
          }
        ],
        "bindings6": [
          {
            "address": "fe80::893a:37c7:1616:69c9",
            "netmask": "ffff:ffff:ffff:ffff::",
            "network": "fe80::"
          }
        ],
        "dhcp": "10.32.22.9",
        "ip": "10.16.113.27",
        "ip6": "fe80::893a:37c7:1616:69c9",
        "mac": "00:50:56:9A:11:79",
        "mtu": 1500,
        "netmask": "255.255.240.0",
        "netmask6": "ffff:ffff:ffff:ffff::",
        "network": "10.16.112.0",
        "network6": "fe80::",
        "scope6": "link"
      }
    },
    "ip": "10.16.113.27",
    "ip6": "fe80::893a:37c7:1616:69c9",
    "mac": "00:50:56:9A:11:79",
    "mtu": 1500,
    "netmask": "255.255.240.0",
    "netmask6": "ffff:ffff:ffff:ffff::",
    "network": "10.16.112.0",
    "network6": "fe80::",
    "primary": "Ethernet0",
    "scope6": "link"
  },
  "os": {
    "architecture": "x64",
    "family": "windows",
    "hardware": "x86_64",
    "name": "windows",
    "release": {
      "full": "10",
      "major": "10"
    },
    "windows": {
      "edition_id": "EnterpriseS",
      "installation_type": "Client",
      "product_name": "Windows 10 Enterprise LTSC 2019",
      "release_id": "1809",
      "system32": "C:\\Windows\\system32"
    }
  },
  "path": "C:\\Program Files\\Puppet Labs\\Puppet\\puppet\\bin;C:\\Program Files\\Puppet Labs\\Puppet\\bin;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\Windows\\System32\\OpenSSH\\;C:\\Packer\\SysInternals;C:\\Program Files\\Git\\cmd;C:\\Program Files\\PowerShell\\6\\;C:\\Program Files\\Puppet Labs\\Puppet\\bin;C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\WindowsApps;",
  "processors": {
    "count": 2,
    "isa": "x64",
    "models": [
      "Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz",
      "Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz"
    ],
    "physicalcount": 2
  },
  "ruby": {
    "platform": "x64-mingw32",
    "sitedir": "C:/Program Files/Puppet Labs/Puppet/puppet/lib/ruby/site_ruby/2.5.0",
    "version": "2.5.7"
  },
  "system_uptime": {
    "days": 4,
    "hours": 117,
    "seconds": 422999,
    "uptime": "4 days"
  },
  "timezone": "Coordinated Universal Time",
  "virtual": "vmware"
}
WINFACTS

WINDOWS_PRIV_KEY = "-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----"

WINDOWS_CERT = "-----BEGIN CERTIFICATE-----
MIIFqzCCA5OgAwIBAgICAbgwDQYJKoZIhvcNAQELBQAwRzFFMEMGA1UEAww8UHVw
cGV0IEVudGVycHJpc2UgQ0EgZ2VuZXJhdGVkIGF0ICsyMDE5LTEwLTI0IDIzOjI5
OjU4ICswMDAwMB4XDTIwMDQwNjIxMzczOVoXDTI1MDQwNjIxMzczOVowMTEvMC0G
A1UEAwwmc29ycnktdW5kZXJjdXQuZGVsaXZlcnkucHVwcGV0bGFicy5uZXQwggIi
MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCrb+fcFBns6p2EvjPvc+4j3L5p
idmwdqE+mZaCHo6tK9m2gGqFy9RbokIRLWe/kGS2RGvyVbkh+Mt415QFKHz7Q/cw
Daf6e1s797HUpX1hLE2eB/MUsMWhQVn8Sd2zQAVYzMomjQJn3MlcRw4XjBN3N1lB
oUhCBIraZW5NIaqAia1X1iwvOkZC+ACWfF/HYG6JnCppY4v1e8t27bFSw/vUQaN6
e2BVcgOyResuTVJV/SvdEq3iD6X4J+GHmGKAGOkhHgHjUcMPqctK3GnI0gLJJX2S
c5BU9XEeoVwS3u/LamaEhYX47d3qtlDXTilQ2J9fdEAOpTCSNqLWqS17hgv6qAOM
1+xFBaBIArYE4WwXvqgSBL4y/TyZT/031LVY9qB0cti+rvOr1wIkpCMLMvz5mQSj
TsmVNlFDLW/+GT3p5iioQE1bIHm4js4e4Xxz2Nu5KW8ixr6OcTxtTASHuoIZpnWS
7nybZ8z2KPuXEREw/+GC1yciAW20gmk567/k2whXFTQqTL9JNyj3i0zbNogMyNph
QA2gEvC1BjRp2VGLKXqj5CVUmNIGiBHpaCgAl9XqxbMO7j9YIr2609ZvBSSibCRL
OvDJwwKEb/vFMQzCupXWOu12gXw7+WtsN+Ut5xFnnYA6Fckvr0HljZKt1grm8zPy
922+jA4d94uP4lrCqQIDAQABo4G2MIGzMDEGCWCGSAGG+EIBDQQkFiJQdXBwZXQg
U2VydmVyIEludGVybmFsIENlcnRpZmljYXRlMB8GA1UdIwQYMBaAFOA5EvqgtBuo
KB56sFwVmcN1m4fcMB0GA1UdDgQWBBQOiguWggvODa9WDjrFOrPOenSzozAMBgNV
HRMBAf8EAjAAMCAGA1UdJQEB/wQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAOBgNV
HQ8BAf8EBAMCBaAwDQYJKoZIhvcNAQELBQADggIBAMLCPqAG8szRni6sK9oi5Q4v
VlfuyPLrXbi8J3N5/cGzkg1Xbr2MdjFDF6gk+7CFcXkYEHqP3pP9EdVpnzzQQgIj
/zKyqXz0C5fPLhJWCxDiqpBhxkfA+FudyuUXJWlUMlEUapzsyfiQ0XfRU9wxwSJL
1TnycUL7k/i2iqtsrrv/EaeZuUs8hWq/UWzuMsBW9IQbq+r7goJsMQqglecB6TXk
IcZ4bgkoIkMg+nhLg27+yQAiqrN9pUTzJKuxQFyKCuqTuSeZty5SUsLiqsmTUNzr
C0PIPplFW1rs/jYcS+dGBl7CPbtCXWFFfsCE9y8hzxJ8cJamyS80fb638BDBTEkW
KsXFPe0USw1Fx3hGMXdWlYUiGBvqI942ZDDm6d0yGz2s8uHHG5njF7z4blmMulU6
DPPEb/U1u35gVd2gygpoCdRnLTP0kvNE5psqsW8lwH8t4O/rVIZa4WUHw70D3FB9
1MgauBraLTFvafTZ0ufLdNMh7kFGo9LTgXnQQacCQDQHct1HbHnrXZONASYa2vP8
ZxMrhPAXhsu07fQrpDuIbygJyFxrWpL+98VjHzn3UWHekQ4nWKTenpMr1WEJ/1NW
DRH4EMxBTtpKT0jXf60MMxfUJYx3PhmyetAciVeFvFEn3HQo8Yu9uFAdEhswqgUH
cdOi9JblJb2+tWfF7H+A
-----END CERTIFICATE-----"
