# == Class: memcached
#
# A module to manage memcached
#
# === Parameters
# [*version*]
#   The package version to install
#
# [*enable*]
#   Should the service be enabled during boot time?
#
# [*start*]
#   Should the service be started by Puppet

include nmpcache::install, nmpcache::config, nmpcache::service

class memcached(
   $version = "present",
   $enable = true,
   $start = true
) {
   class{'memcached::install': } ->
   class{'memcached::config': } ~>
   class{'memcached::service': } ->
   Class["memcached"]
}
