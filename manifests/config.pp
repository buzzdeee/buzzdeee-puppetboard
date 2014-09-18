class puppetboard::config (
  $install_path,
  $config_file,
  $puppetdb_host,
  $puppetdb_port,
  $puppetdb_ssl_verify,
  $puppetdb_key,
  $puppetdb_cert,
  $puppetdb_timeout,
  $dev_listen_host,
  $dev_listen_port,
  $unresponsive_hours,
  $enable_query,
  $puppetboard_loglevel,
) {
  file { "${install_path}${config_file}":
    ensure => 'present',
    owner  => 'root',
    group  => '0',
    mode   => '0644',
    content => template('puppetboard/default_settings.py.erb'),
  }
}
