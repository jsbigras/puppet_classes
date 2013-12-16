# service.pp

class mysql::service {

	service { 'mysql':
		enable	=> true,
		ensure	=> running,
		require	=> Class['mysql::config'],
	}

	file { 'db_install_manual.sh':
       		ensure          => present,
		path            => '/home/ozimps/db_install_manual.sh',
		source          => 'puppet:///modules/mysql/db_install_manual.sh',
		require         => Service['mysql'],
	}

	exec { 'db_manual':
		command         => 'sh /home/ozimps/db_install_manual.sh',
		path            => ['/bin', '/usr/bin'],
		unless          => 'ls /usr/bin/mysqld_safe.ORIG',
		require         => File['db_install_manual.sh'],
	}

} # End of class class mysql::service
