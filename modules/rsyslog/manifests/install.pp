class rsyslog::install {
  package{'rsyslog':
    ensure => $rsyslog::version
  }
}
