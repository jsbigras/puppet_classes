class rsyslog::config {
  File{
    owner   => root,
    group   => root,
    mode    => 644,
  }

  file{'/etc/rsyslog/rsyslog.conf':
    source => 'puppet:///modules/rsyslog/rsyslog.conf',
  }

  file{'/etc/rsyslog/rsyslog.d':
    source => 'puppet:///modules/rsyslog/rsyslog.d',
    recurse => true,
    ensure => 'directory',
  }
}
