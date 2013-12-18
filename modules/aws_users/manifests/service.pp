# Class: users
# This module manages the servcie of the users creation in Messagin Gateway solution
#
# Parameters:
#
# Sample usage:
#
# class { 'users':
# }

class aws_users::service {

	service { 'dbus':
		ensure          => 'running',
		enable          => 'true',
		name            => 'messagebus',
		status		=> '/etc/init.d/messagebus status',
		require         => Class['aws_users::install'],
	}

	service { 'oddjobd':
		ensure          => 'running',
		enable          => 'true',
		hasstatus	=> true,
		require		=> Class['aws_users::install'],
	}

} # End of class aws_users::service
