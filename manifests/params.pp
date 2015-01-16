# Private class, do not use directly.
# The parameters that drive the module.

class puppetboard::params {
  $install_path = '/var/www/puppetboard/'
  $config_file  = 'puppetboard/default_settings.py'
  $puppetdb_host = 'localhost'
  $puppetdb_port = '8080'
  $puppetdb_ssl_verify = 'False'
  $puppetdb_key  = 'None'
  $puppetdb_cert = 'None'
  $puppetdb_timeout = '20'
  $dev_listen_host = '127.0.0.1'
  $dev_listen_port = '5000'
  $unresponsive_hours = '2'
  $enable_query = 'True'
  $puppetboard_loglevel = 'info'
  $service_enable = true
  $service_ensure = running
  $service_flags = ''
  $service_name = 'puppetboard'
  $package_name = 'puppetboard'
  $package_ensure = 'installed'
  $use_puppet_certs = true
}
