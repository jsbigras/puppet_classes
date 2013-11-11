# Class: users::config
# This module manages the configuration of the users creation in Messagin Gateway solution
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

class users_new::config {

	user { 'ozimps':
		ensure		=> present,
		uid		=> 500,
		groups		=> undef,
		comment		=> "${hostname} ozimps",
		managehome	=> true,
	}

	if defined(Class['mysql::server']) {
		user { 'mysql':
			ensure          => present,
			uid             => 510,
			gid             => 510,
			groups          => ['mysql'],
			comment         => "${hostname} mysql",
			managehome      => true,
			require         => Group['mysql'],
		}

		group { 'mysql':
			ensure          => present,
			gid             => 510,
		}
        }

	file { '/home/users':
		ensure		=> directory,
		mode		=> 0777,
	}

	file { '/home/users/.bash_profile':
		ensure          => present,
		source          => 'puppet:///modules/users_new/.bash_profile.USERS',
		require         => File['/home/users'],
	}

	file { '/home/users/.bashrc':
		ensure          => present,
		source          => 'puppet:///modules/users_new/.bashrc.USERS',
		require         => File['/home/users'],
	}

	file { '/etc/profile':
		ensure		=> present,
		source	   	=> 'puppet:///modules/users_new/profile',
	}

} # End of class users_new::config
