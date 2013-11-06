# Class: nmpcache::config
# This module manages the configuration of the unity nmpcache on the server.
#

class nmpcache::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/nmpcache/platform.env /opt/nokia/nmp/instances/nmpcache/platform.env.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/nmpcache/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/nmpcache/platform.env.ORIG',
		require		=> Class['nmpcache::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/nmpcache/platform.properties /opt/nokia/nmp/instances/nmpcache/platform.properties.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/nmpcache/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/nmpcache/platform.properties.ORIG',
		require		=> Class['nmpcache::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/nmpcache/cacheserver/configuration.xml /opt/nokia/nmp/instances/nmpcache/cacheserver/configuration.xml.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/nmpcache/cacheserver/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/nmpcache/cacheserver/configuration.xml.ORIG',
		require		=> Class['nmpcache::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/nmpcache/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/nmpcache/platform.env',
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
		path		=> '/opt/nokia/nmp/instances/nmpcache/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/nmpcache/cacheserver/configuration.xml',
		content		=> template("nmpcache/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

} # End of class nmpcache::config
