# Class: sendmail_server
# This module includes sendmail server.
#
# Parameters:
#
# $operations_email: Operations email address
# $operations_email = '<enter infrastructure mailling list>'
#
# Sample usage:
#
# class { 'sendmail_server':
#       operations_email=> '<enter infrastructure mailling list>',
# }

class sendmail_server_new ( $operations_email  = '<enter infrastructure mailling list>' ) {

	package { ['sendmail', 'sendmail-cf']:
		ensure		=> present,
		provider	=> yum,
	}

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

	file { '/etc/mail/access':
		require		=> Package['sendmail', 'sendmail-cf'],
		content		=> template('sendmail_server/access_server.erb'),
	}

	file { '/etc/mail/genericstable':
		require		=> Package['sendmail', 'sendmail-cf'],
		content		=> template('sendmail_server/genericstable_server.erb'),
	}

	file { '/etc/mail/genericsdomains':
		require		=> Package['sendmail', 'sendmail-cf'],
		content		=> template('sendmail_server/genericsdomains_server.erb'),
	}

	file { '/etc/aliases':
		require		=> Package['sendmail', 'sendmail-cf'],
		content		=> template('sendmail_server/aliases_server.erb'),
	}

	exec { 'newaliases':
		cwd		=> '/etc/mail',
		path		=> ['/bin', '/usr/bin'],
		subscribe	=> File['/etc/aliases'],
		refreshonly	=> true,
	}

	file { '/etc/mail/sendmail.mc':
		require		=> Package['sendmail', 'sendmail-cf'],
		content		=> template('sendmail_server/sendmail.mc_server.erb'),
	}

	exec { 'make':
		command		=> 'make -C /etc/mail; service sendmail restart',
		path		=> ['/bin', '/usr/bin', '/sbin'],
		subscribe	=> File['/etc/mail/sendmail.mc', '/etc/mail/genericstable'],
		refreshonly	=> true,
	}

	service { 'sendmail':
		ensure		=> running,
		enable		=> true,
		restart		=> true,
		require		=> Exec['make'],
	}

} # End of sendmail_server_new
