# config.pp

class mysql::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0755,
	}

	file { 'db_install_auto.sh':
		ensure		=> present,
		path		=> '/home/ozimps/db_install_auto.sh',
		source		=> 'puppet:///modules/mysql/db_install_auto.sh',
		require		=> Class['mysql::server'],
	}

	exec { 'db_auto':
		command		=> 'sh /home/ozimps/db_install_auto.sh \
				&& rm -f /data/mysql/ib*',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /usr/bin/mysqld_safe.ORIG',
		require		=> File['db_install_auto.sh'],
		notify		=> Class['mysql::service'],
	}

} # End of class mysql::config
