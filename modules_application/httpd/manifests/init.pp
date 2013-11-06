# Class: httpd
# This module is making sure the location of the cgi-bin is set to /var/www/cgi-bin
#
# Parameters:
#
# Sample usage:
#
# include httpd
#
class httpd {

	package { ['httpd']:
		ensure          => present,
		provider        => yum,
	}

	file { '/etc/httpd/conf/httpd.conf':
		owner           => root,
		group           => root,
		mode            => 0644,
		source          => 'puppet:///modules/httpd/httpd.conf',
		require         => Package['httpd'],
		notify          => Service['httpd'],
	}

	service { 'httpd':
		ensure          => running,
		enable          => true,
	}

} # End of httpd
