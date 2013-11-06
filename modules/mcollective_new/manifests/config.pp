# Class: mcollective::config
# This module manages the configuration of the mcollective component on the server.
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
# class { 'mcollective':
#       mc_server	=> 'suwpuppet01.mt2.suw.hostings.op',
#       mc_user		=> 'mcollective',
#       mc_password	=> 'marionette',
# }

class mcollective_new::config {

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

	file { 'server.cfg':
		ensure		=> present,
		mode            => 640,
		path		=> '/etc/mcollective/server.cfg',
		content		=> template('mcollective_new/server.cfg.erb'),
		require		=> Class['mcollective_new::install'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'facter_facts.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/facts/facter_facts.rb',
		source		=> 'puppet:///modules/mcollective_new/facter_facts.rb',
		require		=> File['server.cfg'],
	}
		
	file { 'service.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/service.rb',
		source		=> 'puppet:///modules/mcollective_new/service.rb',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'service.ddl':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/service.ddl',
		source		=> 'puppet:///modules/mcollective_new/service.ddl',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'shellcmd.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/shellcmd.rb',
		source		=> 'puppet:///modules/mcollective_new/shellcmd.rb',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'filemgr.ddl':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/filemgr.ddl',
		source		=> 'puppet:///modules/mcollective_new/filemgr.ddl',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'filemgr.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/filemgr.rb',
		source		=> 'puppet:///modules/mcollective_new/filemgr.rb',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'puppetral.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/puppetral.rb',
		source		=> 'puppet:///modules/mcollective_new/puppetral.rb',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'package.ddl':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/package.ddl',
		source		=> 'puppet:///modules/mcollective_new/package.ddl',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'package.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/package.rb',
		source		=> 'puppet:///modules/mcollective_new/package.rb',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'puppetd.ddl':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/puppetd.ddl',
		source		=> 'puppet:///modules/mcollective_new/puppetd.ddl',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

	file { 'puppetd.rb':
		ensure		=> present,
		path		=> '/usr/libexec/mcollective/mcollective/agent/puppetd.rb',
		source		=> 'puppet:///modules/mcollective_new/puppetd.rb',
		require		=> File['server.cfg'],
		notify		=> Class['mcollective_new::service'],
	}

} # End of class mcollective_new::config
