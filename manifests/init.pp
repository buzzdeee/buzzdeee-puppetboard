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
  $puppetdb_proto = $::puppetboard::params::puppetdb_proto,
  $puppetdb_with_event_numbers = $::puppetboard::params::puppetdb_with_event_numbers,
  $puppetdb_ssl_verify = $::puppetboard::params::puppetdb_ssl_verify,
  $puppetdb_key  = $::puppetboard::params::puppetdb_key,
  $puppetdb_cert = $::puppetboard::params::puppetdb_cert,
  $puppetdb_ca = $::puppetboard::params::puppetdb_ca,
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
  $displayed_metrics = $::puppetboard::params::displayed_metrics,
  $inventory_facts = $::puppetboard::params::inventory_facts,
  $default_environment = $::puppetboard::params::default_environment,
  $refresh_rate = $::puppetboard::params::refresh_rate,
  $overview_filter = $::puppetboard::params::overview_filter,
  $show_error_as = $::puppetboard::params::show_error_as,
  $code_prefix_to_remove = $::puppetboard::params::code_prefix_to_remove,
  $daily_reports_chart_enabled = $::puppetboard::params::daily_reports_chart_enabled,
  $daily_reports_chart_days = $::puppetboard::params::daily_reports_chart_days,
  $normal_table_count = $::puppetboard::params::normal_table_count,
  $little_table_count = $::puppetboard::params::little_table_count,
  $table_count_selector = $::puppetboard::params::table_count_selector,
  $service_enable = $::puppetboard::params::service_enable,
  $service_ensure = $::puppetboard::params::service_ensure,
  $service_flags = $::puppetboard::params::service_flags,
  $service_name = $::puppetboard::params::package_name,
  $package_ensure = $::puppetboard::params::package_ensure,
  $package_name = $::puppetboard::params::package_name,
  $use_puppet_certs = $::puppetboard::params::use_puppet_certs,
  $puppet_ssl_dir = $::puppetboard::params::puppet_ssl_dir,
) inherits puppetboard::params {

  # undef config parameters for version < 0.1.0
  if (versioncmp($config_version, '0.1.0') == -1) {
    $real_default_environment = undef
    $real_refresh_rate = undef
    $real_overview_filter = undef
  } else {
    $real_default_environment = $default_environment
    $real_refresh_rate = $refresh_rate
    $real_overview_filter = $overview_filter
  }
  # undef config parameters for version < 0.0.5
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
  if (versioncmp($config_version, '0.2.1') == -1) {
    $real_daily_reports_chart_enabled = undef
    $real_daily_reports_chart_days = undef
    $real_normal_table_count = undef
    $real_little_table_count = undef
    $real_table_count_selector = undef
  } else {
    $real_daily_reports_chart_enabled = $daily_reports_chart_enabled
    $real_daily_reports_chart_days = $daily_reports_chart_days
    $real_normal_table_count = $normal_table_count
    $real_little_table_count = $little_table_count
    $real_table_count_selector = $table_count_selector
  }
  if (versioncmp($config_version, '0.3.0') == -1) {
    $real_displayed_metrics = undef
  } else {
    $real_displayed_metrics = $displayed_metrics
  }
  if (versioncmp($config_version, '1.0.0') == -1) {
    $real_puppetdb_proto = undef
  } else {
    $real_puppetdb_proto = $puppetdb_proto
  }
  if (versioncmp($config_version, '1.1.0') == -1) {
    $real_puppetdb_proto = undef
  } else {
    $real_puppetdb_with_event_numbers = $puppetdb_with_event_numbers
  }
  if (versioncmp($config_version, '3.4.0') == -1) {
    $real_show_error_as = undef
    $real_code_prefix_to_remove = undef
  } else {
    $real_show_error_as = $show_error_as
    $real_code_prefix_to_remove = $code_prefix_to_remove
  }

  class { 'puppetboard::install':
    package_ensure => $package_ensure,
    package_name   => $package_name,
  }

  class { 'puppetboard::config':
    install_path                => $install_path,
    config_file                 => $config_file,
    puppetdb_host               => $puppetdb_host,
    puppetdb_port               => $puppetdb_port,
    puppetdb_ssl_verify         => $puppetdb_ssl_verify,
    puppetdb_key                => $puppetdb_key,
    puppetdb_cert               => $puppetdb_cert,
    puppetdb_ca                 => $puppetdb_ca,
    puppetdb_timeout            => $puppetdb_timeout,
    dev_listen_host             => $dev_listen_host,
    dev_listen_port             => $dev_listen_port,
    unresponsive_hours          => $unresponsive_hours,
    enable_query                => $enable_query,
    puppetboard_loglevel        => $puppetboard_loglevel,
    use_puppet_certs            => $use_puppet_certs,
    puppet_ssl_dir              => $puppet_ssl_dir,
    import_os                   => $real_import_os,
    secret_key                  => $real_secret_key,
    dev_coffee_location         => $real_dev_coffee_location,
    localize_timestamp          => $real_localize_timestamp,
    reports_count               => $real_reports_count,
    offline_mode                => $real_offline_mode,
    enable_catalog              => $real_enable_catalog,
    graph_facts                 => $real_graph_facts,
    displayed_metrics           => $real_displayed_metrics,
    inventory_facts             => $real_inventory_facts,
    refresh_rate                => $real_refresh_rate,
    overview_filter             => $real_overview_filter,
    default_environment         => $real_default_environment,
    daily_reports_chart_enabled => $real_daily_reports_chart_enabled,
    daily_reports_chart_days    => $real_daily_reports_chart_days,
    normal_table_count          => $real_normal_table_count,
    little_table_count          => $real_little_table_count,
    table_count_selector        => $real_table_count_selector,
    show_error_as               => $real_show_error_as,
    code_prefix_to_remove       => $real_code_prefix_to_remove,
    puppetdb_proto              => $real_puppetdb_proto,
    puppetdb_with_event_numbers => $real_puppetdb_with_event_numbers,
  }

  class { 'puppetboard::service':
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    service_flags  => $service_flags,
    service_name   => $service_name,
  }

  Class['puppetboard::install']
  -> Class['puppetboard::config']
  ~> Class['puppetboard::service']
}
