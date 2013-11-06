# Class: postfix
# This module manages Postfix default smtp in Messagin Gateway solution
#
# Parameters:
#
# $postfix_myhostname: The internet domain name that the server will look like
# $postfix_myhostname = 'smtp.unity.mobi'
#
# $postfix_mynetworks: The network IPs of the servers allowed to connect to Postfix
# $postfix_mynetworks =  '127.0.0.1'
#
# $postfix_inet_interfaces: The IP(s) that Postfix will license to.
# $postfix_inet_interfaces = "${myhostname}"
#
# Sample usage:
#
# class { "postfix":
#	postfix_myhostname => [ 'smtp.unity.mobi' ],
#	postfix_mynetworks => [ '127.0.0.1' ],
#	postfix_inet_interfaces => ['servername'],
# }
# 
class postfix_new ( 	$postfix_myhostname	= 'smtp.unity.mobi',
			$postfix_mynetworks	= '127.0.0.1',
			$postfix_inet_interfaces= "${myhostname}" ) {
	
	package { ['postfix']:
		ensure		=> present,
		provider	=> yum,
	}

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	} 

	file { '/etc/postfix/master.cf':
		source		=> 'puppet:///modules/postfix_new/master.cf',
		require		=> Package['postfix'],
		notify 		=> Service['postfix'],
	}

	file { '/etc/postfix/LINUX2':
		mode		=> 0750,
		source		=> 'puppet:///modules/postfix_new/LINUX2',
		require		=> Package['postfix'],
		notify 		=> Service['postfix'],
	}

	file { '/etc/postfix/main.cf':
		content		=> template('postfix_new/main.cf.erb'),
		require		=> Package['postfix'],
		notify 		=> Service['postfix'],
	}

	exec { 'LINUX2':
		command		=> 'sh /etc/postfix/LINUX2',
		path		=> ['/bin', '/usr/bin'],
		subscribe	=> File['/etc/postfix/LINUX2'],
		refreshonly	=> true,
	}

	service { 'postfix':
		ensure		=> running,
		enable		=> true,
		require		=> [
				Package['postfix'],
				File['/etc/postfix/main.cf'],
				File['/etc/postfix/master.cf'],
				File['/etc/postfix/LINUX2']
				],
	}

} # End of class postfix_new
