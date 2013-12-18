# Class: users
# This module manages the servcie of the users creation in Messagin Gateway solution
#
# Parameters:
#
# Sample usage:
#
# class { 'users':
# }

class AWS_users::service {

	service { 'dbus':
		ensure          => 'running',
		enable          => 'true',
		name            => 'messagebus',
		status		=> '/etc/init.d/messagebus status',
		require         => Class['users_new::install'],
	}

	service { 'oddjobd':
		ensure          => 'running',
		enable          => 'true',
		hasstatus	=> true,
		require		=> Class['AWS_users::install'],
	}

} # End of class AWS_users::service
