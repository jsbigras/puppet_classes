# Class: abimport::config
# This module manages the configuration of the unity abimport on the server.
#

class abimport::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/cus/platform.env /opt/nokia/nmp/instances/cus/platform.env.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/cus/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/cus/platform.env.ORIG',
		require		=> Class['abimport::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/cus/platform.properties /opt/nokia/nmp/instances/cus/platform.properties.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/cus/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/cus/platform.properties.ORIG',
		require		=> Class['abimport::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/cus/cus/configuration.xml /opt/nokia/nmp/instances/cus/cus/configuration.xml.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/cus/cus/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/cus/cus/configuration.xml.ORIG',
		require		=> Class['abimport::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/cus/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/cus/platform.env',
		changes		=> [
				"set PLATFORM_JVM_HEAP ${heap}m",
				"set PLATFORM_JVM_OFFHEAP ${offheap}m",
				],
		onlyif		=> [
				"get PLATFORM_JVM_HEAP != ${heap}m",
				"get PLATFORM_JVM_OFFHEAP != ${offheap}m",
				],
		require		=> Exec['platform.env.ORIG'],
	}

	file { 'platform.properties':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/cus/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/cus/cus/configuration.xml',
		content		=> template("abimport/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

} # End of class abimport::config
