# Class: ntp_client
# This module manages ntp_client config in Messagin Gateway solution
#
# Parameters:
#
# $ntp_servers: NTP servers on whic the server will sync
# $ntp_servers = [ '172.16.36.58', '172.16.36.154' ]
#
# Sample usage:
#
# class { 'ntp_client':
#       ntp_servers => [ '172.16.36.58', '172.16.36.154' ],
# }

class ntp_client_new ( $ntp_servers = [ '172.16.36.58', '172.16.36.154' ] ) { 
        
	package { 'ntp':
		ensure		=> present,
		provider	=> yum,
	}	

	file { '/etc/ntp.conf':
		content		=> template('ntp_client_new/ntp.conf.erb'),
		owner		=> root,
		group		=> root,
		mode		=> 0644,
		require		=> Package['ntp'],
        }

	service { 'ntpd':
		enable		=> true,
		ensure		=> running,
		hasrestart	=> true,
		subscribe	=> File['/etc/ntp.conf'],
		require		=> Package['ntp'],
        }

} # End of class ntp_client_new
