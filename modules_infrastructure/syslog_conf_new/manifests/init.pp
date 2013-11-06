# Class: syslog_conf
# This module manages syslog.conf file in Messagin Gateway solution
#
# Parameters:
#
# $syslog_server: Syslog server
# $syslog_server = 'syslog'
#
# Sample usage:
#
# class { 'syslog_conf':
#       syslog_server  => 'syslog',
# }

class syslog_conf_new ( $syslog_server  = 'syslog' ) {

	file { '/etc/syslog.conf':
		content		=> template('syslog_conf_new/syslog.conf.erb'),
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

} # End of class syslog_conf_new
