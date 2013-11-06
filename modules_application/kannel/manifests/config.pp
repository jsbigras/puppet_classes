# Class: kannel::config
# This module manages the configuration of the unity kannel on the server.
#

class kannel::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'monit.cfg.ORIG':
		command		=> 'cp -p /opt/nokia/monit/monit.cfg /opt/nokia/monit/monit.cfg.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/monit/monit.cfg*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/monit/monit.cfg.ORIG',
		require		=> Class['kannel::install'],
	}

	exec { 'kannel.conf.ORIG':
		command		=> 'cp -p /opt/nokia/kannel/etc/example/kannel.conf /opt/nokia/kannel/etc/kannel.conf.ORIG \
				&& cp -p /opt/nokia/kannel/etc/example/kannel.conf /opt/nokia/kannel/etc/kannel.conf \
				&& su - ozimps -c \' dos2unix /opt/nokia/kannel/etc/kannel.conf*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/kannel/etc/kannel.conf.ORIG',
		require		=> Class['kannel::install'],
	}

	exec { 'smsbox_ns.conf.ORIG':
		command		=> 'cp -p /opt/nokia/kannel/etc/example/smsbox_ns.conf /opt/nokia/kannel/etc/smsbox_ns.conf.ORIG \
				&& cp -p /opt/nokia/kannel/etc/example/smsbox_ns.conf /opt/nokia/kannel/etc/smsbox_ns.conf \
				&& su - ozimps -c \' dos2unix /opt/nokia/kannel/etc/smsbox_ns.conf*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/kannel/etc/smsbox_ns.conf.ORIG',
		require		=> Class['kannel::install'],
	}

	exec { 'smsbox_imps.conf.ORIG':
		command		=> 'cp -p /opt/nokia/kannel/etc/example/smsbox_imps.conf /opt/nokia/kannel/etc/smsbox_imps.conf.ORIG \
				&& cp -p /opt/nokia/kannel/etc/example/smsbox_imps.conf /opt/nokia/kannel/etc/smsbox_imps.conf \
				&& su - ozimps -c \' dos2unix /opt/nokia/kannel/etc/smsbox_imps.conf*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/kannel/etc/smsbox_imps.conf.ORIG',
		require		=> Class['kannel::install'],
	}

	exec { 'smsbox_mu.conf.ORIG':
		command		=> 'cp -p /opt/nokia/kannel/etc/example/smsbox_mu.conf /opt/nokia/kannel/etc/smsbox_mu.conf.ORIG \
				&& cp -p /opt/nokia/kannel/etc/example/smsbox_mu.conf /opt/nokia/kannel/etc/smsbox_mu.conf \
				&& su - ozimps -c \' dos2unix /opt/nokia/kannel/etc/smsbox_mu.conf*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/kannel/etc/smsbox_mu.conf.ORIG',
		require		=> Class['kannel::install'],
	}

	file { 'monit.cfg':
		ensure		=> present,
		mode		=> 700,
		path		=> '/opt/nokia/monit/monit.cfg',
		content		=> template('platform/monit.cfg.erb'),
		require		=> Exec['monit.cfg.ORIG'],
	}

	file { 'kannel.conf':
		ensure		=> present,
		path		=> '/opt/nokia/kannel/etc/kannel.conf',
		content		=> template("kannel/kannel.conf-${unity_branch}.erb"),
		require		=> Exec['kannel.conf.ORIG'],
		notify		=> Exec['kannel_configure'],
	}

	file { 'smsbox_ns.conf':
		ensure		=> present,
		path		=> '/opt/nokia/kannel/etc/smsbox_ns.conf',
		content		=> template("kannel/smsbox_ns.conf-${unity_branch}.erb"),
		require		=> Exec['smsbox_ns.conf.ORIG'],
		notify		=> Exec['kannel_configure'],
	}

	file { 'smsbox_imps.conf':
		ensure		=> present,
		path		=> '/opt/nokia/kannel/etc/smsbox_imps.conf',
		content		=> template("kannel/smsbox_imps.conf-${unity_branch}.erb"),
		require		=> Exec['smsbox_imps.conf.ORIG'],
		notify		=> Exec['kannel_configure'],
	}

	file { 'smsbox_mu.conf':
		ensure		=> present,
		path		=> '/opt/nokia/kannel/etc/smsbox_mu.conf',
		content		=> template("kannel/smsbox_mu.conf-${unity_branch}.erb"),
		require		=> Exec['smsbox_mu.conf.ORIG'],
		notify		=> Exec['kannel_configure'],
	}

	exec { 'kannel_configure':
		command		=> 'su - ozimps -c \'kannel configure\'',
		path		=> ['/bin', '/usr/bin', 'home/ozimps/bin'],
		unless		=> 'su - ozimps -c \'kannel summary\' | grep \'Process.*running\'',
		require		=> [
				File['monit.cfg'],
				File['kannel.conf'],
				File['smsbox_ns.conf'],
				File['smsbox_imps.conf'],
				File['smsbox_mu.conf'],
				],
	}

} # End of class kannel::config
