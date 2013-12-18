# Class: users
# This module manages the packages installation of users creation in Messagin Gateway solution
#
# Parameters:
#
# Sample usage:
#
# class { 'users':
# }

class AWS_users::install {

	package { 'ruby-shadow':
		ensure		=> present,
		provider	=> yum,
	}

	package { 'dbus':
		ensure          => present,
		provider        => yum,
	}

	package { 'oddjob':
		ensure		=> present,
		provider	=> yum,
		require         => Package['dbus'],
	}

} # End of class AWS_users::install
