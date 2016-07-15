# Private class, do not use directly.
# The parameters that drive the module.

class puppetboard::params {
  case $::osfamily {
    'OpenBSD': {
      case $::kernelversion {
        '5.7', '5.8': {
          $config_version = '0.0.4'
        }
        '5.9': {
          $config_version = '0.0.5'
        }
        default: {
          $config_version = '0.2.0'
        }
      }
    }
  }
  case $::puppetversion {
    /^3.*/: {
      $puppet_ssl_dir = '/etc/puppet/ssl'
    }
    /^4.*/: {
      $puppet_ssl_dir = '/etc/puppetlabs/puppet/ssl'
    }
    default: {
      error("${::module_name} only supports Puppet versions 3 or 4")
    }
  }

  $install_path = '/var/www/puppetboard/'
  $config_file  = 'puppetboard/default_settings.py'
  $puppetdb_host = 'localhost'
  $puppetdb_port = '8080'
  $puppetdb_ssl_verify = false
  $puppetdb_key  = 'None'
  $puppetdb_cert = 'None'
  $puppetdb_timeout = '20'
  $dev_listen_host = '127.0.0.1'
  $dev_listen_port = '5000'
  $unresponsive_hours = '2'
  $enable_query = 'True'
  $puppetboard_loglevel = 'info'


  # Below are the config items necessary/added
  # for the 0.0.5
  $secret_key = 'default'
  $import_os  = true
  $dev_coffee_location = 'coffee'
  $localize_timestamp = 'True'
  $reports_count = '10'
  $offline_mode = 'False'
  $enable_catalog = 'False'
  $graph_facts =  [ 'architecture',
                    'domain',
                    'lsbcodename',
                    'lsbdistcodename',
                    'lsbdistid',
                    'lsbdistrelease',
                    'lsbmajdistrelease',
                    'netmask',
                    'osfamily',
                    'puppetversion',
                    'processorcount',
                  ]
  $inventory_facts =  [ [ 'Hostname', 'fqdn', ],
                        [ 'IP Address', 'ipaddress', ],
                        [ 'OS', 'lsbdistdescription', ],
                        [ 'Architecture', 'hardwaremodel', ],
                        [ 'Kernel Version', 'kernelrelease', ],
                        [ 'Puppet Version', 'puppetversion', ],
                      ]

  # Below are config items necessary/added
  # 0.1.x
  $default_environment = 'production'
  $refresh_rate = '30'

  $service_enable = true
  $service_ensure = running
  $service_flags = ''
  $service_name = 'puppetboard'
  $package_name = 'puppetboard'
  $package_ensure = 'installed'
  $use_puppet_certs = true
}
