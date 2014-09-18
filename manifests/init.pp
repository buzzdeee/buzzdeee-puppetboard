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
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class puppetboard (
  $install_path = $::puppetboard::params::install_path,
  $config_file  = $::puppetboard::params::config_file,
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
  $service_enable = $::puppetboard::params::service_enable,
  $service_ensure = $::puppetboard::params::service_ensure,
  $service_flags = $::puppetboard::params::service_flags,
  $service_name = $::puppetboard::params::package_name,
  $package_name = $::puppetboard::params::package_name,
) inherits puppetboard::params {


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
  }

  class { 'puppetboard::service':
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    service_flags  => $service_flags,
    service_name   => $service_name,
  }

  Class['puppetboard::install'] ->
  Class['puppetboard::config'] ->
  Class['puppetboard::service']
}
