# Class: mcollective server::config
# This module manage the configuration of the mcollective component on the server.
#
# Parameters:
#
# $mc_server: mcollective server
# $mc_server = 'suwpuppet01.mt2.suw.hostings.op'
#
# $mc_user: mcollective username
# $mc_user = 'mcollective'
#
# $mc_password: mcollective password
# $mc_password = 'marionette'
#
# Sample usage:
#
# class { 'mcollective_server':
#       mc_server       => 'suwpuppet01.mt2.suw.hostings.op',
#       mc_user         => 'mcollective',
#       mc_password     => 'marionette',
# }

class mcollective_server_new::config {

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
                owner		=>	root,
                group		=>	root,
                mode		=>	0744,
	}

	file { 'client.cfg':
		ensure		=>	present,
		path		=>	'/etc/mcollective/client.cfg',
                mode		=>	0640,
		content		=>	template('mcollective_server_new/client.cfg.erb'),
		require		=>	Class['mcollective_server_new::install'],
		notify		=>	Class['mcollective_server_new::service'],
	}

	file { 'activemq.xml':
		ensure		=>	present,
		path		=>	'/etc/activemq/activemq.xml',
                mode		=>	0644,
		content		=>	template('mcollective_server_new/activemq.xml.erb'),
		require		=>	Class['mcollective_server_new::install'],
		notify		=>	Class['mcollective_server_new::service'],
	}

	file { 'mc-service':
		ensure		=>	present,
                path		=>	'/usr/libexec/mcollective/mcollective/application/mc-service',
                source		=>	'puppet:///modules/mcollective_server_new/mc-service',
                require		=>      File['client.cfg'],
        }

	file { '/usr/local/sbin/mc-service':
		ensure		=>	link,
		target		=>	'/usr/libexec/mcollective/mcollective/application/mc-service'
	}

	file { 'mc-filemgr':
		ensure		=>	present,
                path		=>	'/usr/libexec/mcollective/mcollective/application/mc-filemgr',
                source		=>	'puppet:///modules/mcollective_server_new/mc-filemgr',
                require		=>	File['client.cfg'],
        }

	file { '/usr/local/sbin/mc-filemgr':
		ensure		=>	link,
		target		=>	'/usr/libexec/mcollective/mcollective/application/mc-filemgr'
	}

	file { 'mc-shellcmd':
		ensure		=>	present,
                path		=>	'/usr/libexec/mcollective/mcollective/application/mc-shellcmd',
                source		=>	'puppet:///modules/mcollective_server_new/mc-shellcmd',
                require		=>	File['client.cfg'],
        }

	file { '/usr/local/sbin/mc-shellcmd':
		ensure		=>	link,
		target		=>	'/usr/libexec/mcollective/mcollective/application/mc-shellcmd'
	}

	file { 'mc-package':
		ensure		=>	present,
                path		=>	'/usr/libexec/mcollective/mcollective/application/mc-package',
                source		=>	'puppet:///modules/mcollective_server_new/mc-package',
                require		=>	File['client.cfg'],
        }

	file { '/usr/local/sbin/mc-package':
		ensure		=>	link,
		target		=>	'/usr/libexec/mcollective/mcollective/application/mc-package'
	}

} # End of class mcollective_server_new::config
