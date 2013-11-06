# init.pp

class oracle_client {

	package { 'oracle-client-custom':
		ensure		=> installed,
		provider	=> yum,
		require		=> Class['users'],
	}

	exec { 'post_oracle_client1':
		command		=> 'find /u01 -exec chmod a+r {} \; ; find /u01 -type d -exec chmod a+rx {} \;',
		path		=> ['/usr/bin/', '/bin'],
		subscribe	=> Package['oracle-client-custom'],
		refreshonly	=> true,
	}

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
	}

	file { 'bash_oracle':
		ensure		=> present,
		path		=> '/home/ozimps/.bash_oracle',
		source		=> 'puppet:///modules/oracle_client/bash_oracle',
		require		=> Package['oracle-client-custom'],
	}

	if $my_env == 'loadtest' {
		file { 'tnsnames.ora':
                	ensure          => present,
	                path            => '/u01/app/oracle/product/10.2.0/client_1/network/admin/tnsnames.ora',
	                source          => 'puppet:///modules/oracle_client/tnsnames.ora.LOADTEST',
	                require         => Package['oracle-client-custom'],
        	}
	}
	
}
