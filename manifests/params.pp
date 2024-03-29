# Private class, do not use directly.
# The parameters that drive the module.

class puppetboard::params {
  case $facts['os']['family'] {
    'OpenBSD': {
      case $::kernelversion {
        '5.7', '5.8': {
          $config_version = '0.0.4'
        }
        '5.9': {
          $config_version = '0.0.5'
        }
        '6.0': {
          $config_version = '0.2.0'
        }
        '6.1': {
          $config_version = '0.2.1'
        }
        '6.2': {
          $config_version = '0.3.0'
        }
        default: {
          $config_version = '3.4.0'
        }
      }
    }
    default: {
      $config_version = '3.4.1'
    }
  }
  case $::puppetversion {
    /^3.*/: {
      $puppet_ssl_dir = '/etc/puppet/ssl'
    }
    default: {
      $puppet_ssl_dir = '/etc/puppetlabs/puppet/ssl'
    }
  }

  $install_path = '/var/www/puppetboard/'
  $config_file  = 'puppetboard/default_settings.py'
  $puppetdb_host = 'localhost'
  $puppetdb_port = '8080'
  $puppetdb_ssl_verify = false
  $puppetdb_key  = 'None'
  $puppetdb_cert = 'None'
  $puppetdb_ca = 'None'
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
  $overview_filter = 'None'

  # Below are config items added for 0.2.1
  $daily_reports_chart_enabled = 'True'
  $daily_reports_chart_days = '8'
  $normal_table_count = '100'
  $little_table_count = '10'
  $table_count_selector = '[10, 20, 50, 100, 500]'

  # Below are config items added for 0.3.0
  $displayed_metrics =  [ 'resources.total',
                          'events.failure',
                          'events.success',
                          'resources.skipped',
                          'events.noop',
                        ]

  $puppetdb_proto = 'https'
  $puppetdb_with_event_numbers = 'True'

  # added with 3.4.0
  $show_error_as = 'friendly'	# or 'raw'
  $code_prefix_to_remove = '/etc/puppetlabs/code/environments'

  $service_enable = true
  $service_ensure = running
  $service_flags = ''
  $service_name = 'puppetboard'
  $package_name = 'puppetboard'
  $package_ensure = 'installed'
  $use_puppet_certs = true
}
