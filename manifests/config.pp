# Private class, do not use directly.
# Takes care about the configuration file,
# and that configured SSL keys are in place.

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
  $use_puppet_certs,
  $import_os,
  $secret_key,
  $dev_coffee_location,
  $localize_timestamp,
  $reports_count,
  $offline_mode,
  $enable_catalog,
  $graph_facts,
  $inventory_facts,
) {
  file { "${install_path}${config_file}":
    ensure  => 'present',
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('puppetboard/default_settings.py.erb'),
  }

  if $use_puppet_certs {
    file { '/etc/puppetboard':
      ensure => 'directory',
      owner  => 'root',
      group  => '0',
      mode   => '0755',
    }
    exec { 'copy puppetboard_key':
      command => "/bin/cp /etc/puppet/ssl/private_keys/${::fqdn}.pem ${puppetdb_key} && chmod 0644 ${puppetdb_key}",
      creates => $puppetdb_key,
      require => File['/etc/puppetboard'],
    }
    exec { 'copy puppetboard_cert':
      command => "/bin/cp /etc/puppet/ssl/certs/${::fqdn}.pem ${puppetdb_cert}",
      creates => $puppetdb_cert,
      require => File['/etc/puppetboard'],
    }
  }

}
