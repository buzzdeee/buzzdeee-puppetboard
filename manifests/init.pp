# == Class: puppetboard
#
# Full description of class puppetboard here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'puppetboard':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Sebastian Reitenbach, unless otherwise noted.
#
class puppetboard (
  $install_path = $::puppetboard::params::install_path,
  $config_file  = $::puppetboard::params::config_file,
  $config_version = $::puppetboard::params::config_version,
  $puppetdb_host = $::puppetboard::params::puppetdb_host,
  $puppetdb_port = $::puppetboard::params::puppetdb_port,
  $puppetdb_ssl_verify = $::puppetboard::params::puppetdb_ssl_verify,
  $puppetdb_key  = $::puppetboard::params::puppetdb_key,
  $puppetdb_cert = $::puppetboard::params::puppetdb_cert,
  $puppetdb_timeout = $::puppetboard::params::puppetdb_timeout,
  $dev_listen_host = $::puppetboard::params::dev_listen_host,
  $dev_listen_port = $::puppetboard::params::dev_listen_port,
  $unresponsive_hours = $::puppetboard::params::unresponsive_hours,
  $enable_query = $::puppetboard::params::enable_query,
  $puppetboard_loglevel = $::puppetboard::params::puppetboard_loglevel,
  $import_os = $::puppetboard::params::import_os,
  $secret_key = $::puppetboard::params::secret_key,
  $dev_coffee_location = $::puppetboard::params::dev_coffee_location,
  $localize_timestamp = $::puppetboard::params::localize_timestamp,
  $reports_count = $::puppetboard::params::reports_count,
  $offline_mode = $::puppetboard::params::offline_mode,
  $enable_catalog = $::puppetboard::params::enable_catalog,
  $graph_facts = $::puppetboard::params::graph_facts,
  $inventory_facts = $::puppetboard::params::inventory_facts,
  $service_enable = $::puppetboard::params::service_enable,
  $service_ensure = $::puppetboard::params::service_ensure,
  $service_flags = $::puppetboard::params::service_flags,
  $service_name = $::puppetboard::params::package_name,
  $package_ensure = $::puppetboard::params::package_ensure,
  $package_name = $::puppetboard::params::package_name,
  $use_puppet_certs = $::puppetboard::params::use_puppet_certs,
) inherits puppetboard::params {

  if (versioncmp($config_version, '0.0.5') == -1) {
    $real_import_os = undef
    $real_secret_key = undef
    $real_dev_coffee_location = undef
    $real_localize_timestamp = undef
    $real_reports_count = undef
    $real_offline_mode = undef
    $real_enable_catalog = undef
    $real_graph_facts = undef
    $real_inventory_facts = undef
  } else {
    $real_import_os = $import_os
    $real_secret_key = $secret_key
    $real_dev_coffee_location = $dev_coffee_location
    $real_localize_timestamp = $localize_timestamp
    $real_reports_count = $reports_count
    $real_offline_mode = $offline_mode
    $real_enable_catalog = $enable_catalog
    $real_graph_facts = $graph_facts
    $real_inventory_facts = $inventory_facts
  }

  class { 'puppetboard::install':
    package_ensure => $package_ensure,
    package_name   => $package_name,
  }

  class { 'puppetboard::config':
    install_path         => $install_path,
    config_file          => $config_file,
    puppetdb_host        => $puppetdb_host,
    puppetdb_port        => $puppetdb_port,
    puppetdb_ssl_verify  => $puppetdb_ssl_verify,
    puppetdb_key         => $puppetdb_key,
    puppetdb_cert        => $puppetdb_cert,
    puppetdb_timeout     => $puppetdb_timeout,
    dev_listen_host      => $dev_listen_host,
    dev_listen_port      => $dev_listen_port,
    unresponsive_hours   => $unresponsive_hours,
    enable_query         => $enable_query,
    puppetboard_loglevel => $puppetboard_loglevel,
    use_puppet_certs     => $use_puppet_certs,
    import_os            => $real_import_os,
    secret_key           => $real_secret_key,
    dev_coffee_location  => $real_dev_coffee_location,
    localize_timestamp   => $real_localize_timestamp,
    reports_count        => $real_reports_count,
    offline_mode         => $real_offline_mode,
    enable_catalog       => $real_enable_catalog,
    graph_facts          => $real_graph_facts,
    inventory_facts      => $real_inventory_facts,
  }

  class { 'puppetboard::service':
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    service_flags  => $service_flags,
    service_name   => $service_name,
  }

  Class['puppetboard::install'] ->
  Class['puppetboard::config'] ~>
  Class['puppetboard::service']
}
