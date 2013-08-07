# == Class: rsyslog::server
#
# A module to manage rsyslog server
#
# === Parameters
# none

include rsyslog::server::config

class rsyslog::server {
  class{'rsyslog::server::config': } ~>
  class{'rsyslog::service': } ->
  Class["rsyslog::server"]
}
