# Class: users
# This module manages the servcie of the users creation in Messagin Gateway solution
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

class users_new::service {

	service { 'dbus':
		ensure          => 'running',
		enable          => 'true',
		name            => 'messagebus',
		status		=> '/etc/init.d/messagebus status',
		require         => Class['users_new::install'],
	}

	service { 'oddjobd':
		ensure          => $lsbdistrelease ? {
				   /^5/ => 'running',
				   /^4/ => 'stopped',
		},
		enable          => $lsbdistrelease ? {
				   /^5/ => 'true',
				   /^4/ => 'false',
		},
		hasstatus	=> true,
		require		=> Class['users_new::install'],
	}

} # End of class users_new::service
