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
		require		=> Class['users_new::install'],
	}

	user { 'panic':
		ensure		=> present,
		uid		=> 502,
		groups		=> wheel,
		password	=> '$1$54sGtoYR$97A95/c/v.nwmQhgTR/L70',
		comment		=> "${hostname} we are in Trouble",
		managehome	=> true,
		require		=> Class['users_new::install'],
	}

	if $my_role == 'db' {
		user { 'oracle':
			ensure		=> present,
			uid		=> 510,
			gid		=> oinstall,
			groups		=> ['oinstall', 'dba'],
			comment		=> "${hostname} oracle",
			require		=> Group['oinstall', 'dba'],
			managehome	=> true,
		}

		group { 'oinstall':
			ensure		=> present,
			gid		=> 510,
		}

		group { 'dba':
			ensure		=> present,
			gid		=> 511,
		}
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

	user { 'root':
		comment		=> $hostname,	
	}

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

	file { '/etc/pam.d/sshd':
		ensure		=> present,
		content		=> $lsbdistrelease ? {
				   /^5/ => template('users_new/pam.sshd.RH5.erb'),
				   /^4/ => template('users_new/pam.sshd.RH4.erb'),
		}			
	}

#	file { '/etc/pam.d/system-auth':
#		ensure		=> present,
#		content		=> $lsbdistrelease ? {
#				   /^5/ => template('users_new/system-auth.erb.RH5'),
#				   /^4/ => template('users_new/system-auth.erb.RH4'),
#		}
#	}

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


#	file { '/home/ozimps/.bash_profile':
#		ensure		=> present,
#		owner		=> ozimps,
#		group		=> ozimps,
#		source		=> 'puppet:///modules/users_new/.bash_profile.OZIMPS',
#		require		=> User['ozimps'],
#	}

	file { '/etc/profile':
		ensure		=> present,
		source		=> $my_role ? {
				   /db/ => 'puppet:///modules/users_new/profile.DB',
				   default => 'puppet:///modules/users_new/profile',
		}
	}

	augeas { 'logins.defs':
		context         => '/files/etc/login.defs',
		changes         => ['set UID_MAX 999', 'set GID_MAX 999'],
		require		=> Class['users_new::install'],
	}

} # End of class users_new::config
