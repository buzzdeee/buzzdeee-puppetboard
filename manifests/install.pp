# Private class, do not use directly.
# Takes care about the installation.

class puppetboard::install (
  $package_name,
  $package_ensure,
){
  package { $package_name:
    ensure => $package_ensure,
  }
}
