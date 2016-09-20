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
  $puppet_ssl_dir,
  $import_os,
  $secret_key,
  $dev_coffee_location,
  $localize_timestamp,
  $reports_count,
  $offline_mode,
  $enable_catalog,
  $graph_facts,
  $inventory_facts,
  $default_environment,
  $refresh_rate,
  $overview_filter,
) {
  file { "${install_path}${config_file}":
    ensure  => 'present',
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('puppetboard/default_settings.py.erb'),
  }

  if $use_puppet_certs {
    $config_keydir = dirname($puppetdb_key)
    $config_certdir = dirname($puppetdb_key)
    file { $config_keydir:
      ensure => 'directory',
      owner  => 'root',
      group  => '0',
      mode   => '0755',
    }
    if $config_keydir != $config_certdir {
      file { $config_certdir:
        ensure => 'directory',
        owner  => 'root',
        group  => '0',
        mode   => '0755',
      }
    }

    file { $puppetdb_key:
      owner  => 'root',
      group  => 'www',
      mode   => '0640',
      source => "${puppet_ssl_dir}/private_keys/${::fqdn}.pem",
      require => File[$config_keydir]
    }
    file { $puppetdb_cert:
      owner  => 'root',
      group  => 'www',
      mode   => '0640',
      source => "${puppet_ssl_dir}/certs/${::fqdn}.pem",
      require => File[$config_certdir],
    }
  }

}
