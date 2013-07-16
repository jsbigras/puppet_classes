# == Class: ntp
#
# A module to manage ntp
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
# All other parameters are for the ntp config template

include ntp::install, ntp::config, ntp::service

class memcached(
   $version = "present",
   $enable = true,
   $start = true,

   $ntpservers = [ '0.centos.pool.ntp.org', '1.centos.pool.ntp.org', '2.centos.pool.ntp.org' ]
) {
   class{'ntp::install': } ->
   class{'ntp::config': } ~>
   class{'ntp::service': } ->
   Class["ntp"]
}
