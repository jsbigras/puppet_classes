class rsyslog::config {
  File{
    owner   => root,
    group   => root,
    mode    => 644,
  }

  file{'/etc/rsyslog/rsyslog.d':
    source => 'puppet:///modules/rsyslog/server/rsyslog.d',
    recurse => true,
  }
}
