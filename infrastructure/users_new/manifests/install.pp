# Class: users
# This module manages the packages installation of users creation in Messagin Gateway solution
#
# Parameters:
#
# $my_role: The role of the server in this environment.
# $my_role = '<server role>'
#
# Sample usage:
#
# class { 'users':
#       my_role => '<server role>',
# }

class users_new::install {

	package { 'ruby-shadow':
		ensure		=> present,
		provider	=> yum,
	}

#	package { 'augeas':
#		ensure		=> present,
#		provider	=> yum,
#	}

	package { 'dbus':
		ensure          => present,
		provider        => yum,
	}

	package { 'oddjob':
		ensure		=> present,
		provider	=> yum,
		require         => Package['dbus'],
	}

} # End of class users_new::install
