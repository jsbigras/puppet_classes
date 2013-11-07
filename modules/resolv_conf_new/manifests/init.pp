# Class: resolv_conf
# This module manages resolv.conf file in Messagin Gateway solution
#
# Parameters:
#
# $dns_servers: DNS server that will populare /etc/resolv.conf
# $dns_servers = [ '192.168.130.101', '192.168.130.102' ]
#
# Sample usage:
#
# class { 'resolv_conf':
#       dns_servers => [ '192.168.130.101', '192.168.130.102' ],
# }

class resolv_conf_new ( $dns_servers  = [ '10.223.204.70', '10.223.204.71' ] ) {

	file { '/etc/resolv.conf':
		owner		=> root,
		group		=> root,
		mode		=> 0644,
		content		=> template('resolv_conf_new/resolv_conf.erb'),
	}

} # End of class resolv_conf_new
