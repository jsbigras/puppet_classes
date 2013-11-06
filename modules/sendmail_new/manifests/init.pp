# Class: sendmail
# This module includes sendmail client in Messagin Gateway solution
#
# Parameters:
#
# $operations_email: Operations email address
# $operations_email = '<enter infrastructure mailling list>'
#
# $mailrelay: Mail relay server
# $mailrelay = 'mailhost'
#
# Sample usage:
#
# class { 'sendmail':
#       operations_email=> '<enter infrastructure mailling list>',
#       mailrelay   	=> 'mailhost',
# }

class sendmail_new ( $operations_email	= '<enter infrastructure mailling list>',
		     $mailrelay 	= 'mailhost' ) {

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

	file { '/etc/mail/genericstable':
		require		=> Package['sendmail', 'sendmail-cf'],
		content		=> template('sendmail_new/genericstable.erb'),
	}

	file { '/etc/mail/genericsdomains':
		require		=> File['/etc/mail/genericstable'],
		content		=> template('sendmail_new/genericsdomains.erb'),
	}

	file { '/etc/mail/aliases':
		require		=> File['/etc/mail/genericsdomains'],
		content		=> template('sendmail_new/aliases.erb'),
	}

	exec { 'newaliases':
		cwd		=> '/etc/mail',
		path		=> ['/bin', '/usr/bin'],
		subscribe	=> File['/etc/mail/aliases'],
		refreshonly	=> true,
	}

	file { '/etc/mail/sendmail.mc':
		require		=> File['/etc/mail/genericsdomains'],
		content		=> template('sendmail_new/sendmail.mc.erb'),
	}

	exec { 'make':
		cwd		=> '/etc/mail',
		path		=> ['/bin', '/usr/bin'],
		subscribe	=> File['/etc/mail/sendmail.mc'],
		refreshonly	=> true,
	}

	service { 'sendmail':
		ensure		=> running,
		enable		=> true,
#		restart		=> true,
		require		=> Exec['make'],
	}

} # End of class sendmail_new
