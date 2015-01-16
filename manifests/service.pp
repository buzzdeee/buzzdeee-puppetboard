# Private class, do not use directly.
# Takes care about managing the service.

class puppetboard::service (
  $service_name,
  $service_ensure,
  $service_enable,
  $service_flags,
){
  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
    flags  => $service_flags,
  }
}
