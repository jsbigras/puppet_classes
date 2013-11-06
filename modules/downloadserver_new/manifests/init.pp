# Class: limits_conf
# This module manages limit.conf file in Messagin Gateway solution
#
# Parameters:
#
# $operations_email: Operations email address
# $operations_email = '<enter infrastructure mailling list>'
#
# Sample usage:
#
# class { 'downloadserver':
#       operations_email  => '<enter infrastructure mailling list>',
# }

class downloadserver_new ( $operations_email  = '<enter infrastructure mailling list>' ) {

	package { ['httpd', 'php53-5.3.3']:
		ensure          => present,
		provider        => yum,
	}

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File { 
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

	file { '/etc/httpd/conf/httpd.conf':
		content		=> template('downloadserver_new/httpd_conf.erb'),
		require		=> Package['httpd'],
	}

	file { '/etc/httpd/conf.d/welcome.conf':
		source		=> 'puppet:///modules/downloadserver_new/welcome.conf',
	}

	service { 'httpd':
		ensure          => running,
		enable          => true,
		require		=> Exec['httpd-reload'],
	}

	exec { 'httpd-reload':
		command 	=> '/etc/init.d/httpd reload',
		refreshonly 	=> true,
		require 	=> Package['httpd'],
		subscribe	=> File['/etc/httpd/conf/httpd.conf', '/etc/httpd/conf.d/welcome.conf'],
	}

} # End of class downloadserver_new
