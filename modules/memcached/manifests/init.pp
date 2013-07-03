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
#
# All other parameters are for the memcached config template

include memcached::install, memcached::config, memcached::service

class memcached(
   $version = "present",
   $enable = true,
   $start = true,

   $port = "11211",
   $user = "memcached",
   $maxconn = "1024",
   $cachesize = "64",
   $options = ""

) {
   class{'memcached::install': } ->
   class{'memcached::config': } ~>
   class{'memcached::service': } ->
   Class["memcached"]
}
