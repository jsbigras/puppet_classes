# == Class: rsyslog
#
# A module to manage rsyslog
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
# All other parameters are for the rsyslog config template

include rsyslog::install, rsyslog::config, rsyslog::service

class rsyslog(
  $version = "present",
  $enable = true,
  $start = true,

) {
  class{'rsyslog::install': } ->
  class{'rsyslog::config': } ~>
  class{'rsyslog::service': } ->
  Class["rsyslog"]
}
