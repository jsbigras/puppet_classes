# Class: users::config
# This module manages the configuration of the users creation in Messagin Gateway solution
#
# Parameters:
#
# Sample usage:
#
# class { 'users':
# }

class AWS_users::config {

	user { 'ozimps':
		ensure		=> present,
		uid		=> 500,
		groups		=> undef,
		comment		=> "${hostname} ozimps",
		managehome	=> true,
		require		=> Class['users_new::install'],
	}

} # End of class AWS_users::config
