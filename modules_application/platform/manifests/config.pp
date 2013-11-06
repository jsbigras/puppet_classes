# Class: platform::config
# This module manages the configuration of the unity platform and monit on the server.
#

class platform::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'monit.cfg.ORIG':
		command		=> 'cp -p /opt/nokia/monit/monit.cfg /opt/nokia/monit/monit.cfg.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/monit/monit.cfg*\'', 
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/monit/monit.cfg.ORIG',
		require		=> Class['platform::install'],
	}

	exec { 'transactionrecords.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/conf/transactionrecords.xml /opt/nokia/nmp/conf/transactionrecords.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/conf/transactionrecords.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/conf/transactionrecords.xml.ORIG',
		require		=> Class['platform::install'],
	}

	file { 'monit.cfg':
		ensure		=> present,
		mode		=> 700,
		path		=> '/opt/nokia/monit/monit.cfg',
		content		=> template('platform/monit.cfg.erb'),
		require		=> Exec['monit.cfg.ORIG'],
	}

	exec { 'Restart monit process':
		command		=> 'kill -9 `ps -ef | grep monit | egrep -v root |  awk \'{ print $2 }\'`', 
		path		=> ['/bin', '/usr/bin'],
		onlyif		=> 'netstat -an | grep ":3333" | grep LISTEN',
		require		=> File['monit.cfg'],
	}

	file { 'transactionrecords.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/conf/transactionrecords.xml',
		content		=> template('platform/transactionrecords.xml.erb'),
		require		=> Exec['transactionrecords.xml.ORIG'],
	}

} # End of class platform::config
