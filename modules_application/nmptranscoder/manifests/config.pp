# Class: nmptranscoder::config
# This module manages the configuration of the unity nmptranscoder on the server.
#

class nmptranscoder::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/nmptranscoder/platform.env /opt/nokia/nmp/instances/nmptranscoder/platform.env.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/nmptranscoder/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/nmptranscoder/platform.env.ORIG',
		require		=> Class['nmptranscoder::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/nmptranscoder/platform.properties /opt/nokia/nmp/instances/nmptranscoder/platform.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/nmptranscoder/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/nmptranscoder/platform.properties.ORIG',
		require		=> Class['nmptranscoder::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/nmptranscoder/application/configuration.xml /opt/nokia/nmp/instances/nmptranscoder/application/configuration.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/nmptranscoder/application/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/nmptranscoder/application/configuration.xml.ORIG',
		require		=> Class['nmptranscoder::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/nmptranscoder/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/nmptranscoder/platform.env',
		changes		=> [
				"set PLATFORM_JVM_HEAP ${heap}m",
				"set PLATFORM_JVM_OFFHEAP ${offheap}m",
				],
		onlyif          => [
				"get PLATFORM_JVM_HEAP != ${heap}m",
				"get PLATFORM_JVM_OFFHEAP != ${offheap}m",
				],
		require         => Exec['platform.env.ORIG'],
	}

	file { 'platform.properties':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/nmptranscoder/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/nmptranscoder/application/configuration.xml',
		content		=> template("nmptranscoder/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

} # End of class nmptranscoder::config
