class rsyslog::service {
  $ensure = $rsyslog::start ? {true => running, default => stopped}

  service{"rsyslog":
    ensure  => $ensure,
    enable  => $rsyslog::enable,
  }
}
