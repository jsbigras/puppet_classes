# Class: mysql::server
# This module install the Mysql Client and Server.
#
# Parameters:
#
# $version: MySql version.
# $version         = '5.6.14-1.rhel5'
#
# Sample usage:
#
# class { 'mysql::server':
#       version                 => '5.6.14-1.rhel5',
#       stage                   => post,
# }

class mysql::server (   $stage			= post,
			$version                = '5.6.14-1.rhel5' ) {

	# We include the client rpm to the MySQL server too.
	include mysql::client, mysql::config, mysql::service

	package { 'MySQL-devel':
		ensure		=> ${version},
		provider	=> yum,
	}	

	package { 'MySQL-server':
		ensure		=> ${version},
		provider	=> yum,
	}	

	package { 'MySQL-shared':
		ensure		=> ${version},
		provider	=> yum,
	}	

	package { 'MySQL-shared-compat':
		ensure		=> ${version},
		provider	=> yum,
	}	

} # End of class mysql::server
