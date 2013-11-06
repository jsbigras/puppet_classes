# init.pp

class loadtest_scripts {

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
                owner => 	root,
                group => 	root,
                mode => 	0744,
	}

	file { '/etc/init.d/cpu_mon':
		source =>	'puppet:///modules/loadtest_scripts/cpu_mon',
		require =>	Package['net-snmp'],
	}
	
	file { '/etc/snmp/monitorCPU.sh':
		source =>	'puppet:///modules/loadtest_scripts//monitorCPU.sh',
		require =>	Package['net-snmp'],
	}

	file { '/etc/snmp/readCPU.sh':
		source =>	'puppet:///modules/loadtest_scripts///readCPU.sh',
		require =>	Package['net-snmp'],
	}

	service { 'cpu_mon':
		enable =>	true,
		ensure =>	running,
		hasstatus =>	false,
		status =>	'ps -C monitorCPU.sh',
		subscribe =>    File['/etc/init.d/cpu_mon'],
		require =>	File['/etc/init.d/cpu_mon'],
	}

}
