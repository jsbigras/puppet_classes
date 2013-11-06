# Class: pushserver::config
# This module manages the configuration of the unity pushserver on the server.
#

class pushserver::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/platform.env /opt/nokia/nmp/instances/pushserver/platform.env.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/platform.env.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/platform.properties /opt/nokia/nmp/instances/pushserver/platform.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/platform.properties.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/application/configuration.xml /opt/nokia/nmp/instances/pushserver/application/configuration.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/application/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/application/configuration.xml.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'caching.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/conf/caching.xml /opt/nokia/nmp/instances/pushserver/conf/caching.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/conf/caching.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/conf/caching.xml.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'farm.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/conf/farm.xml /opt/nokia/nmp/instances/pushserver/conf/farm.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/conf/farm.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/conf/farm.xml.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'notification.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/conf/notification.xml /opt/nokia/nmp/instances/pushserver/conf/notification.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/conf/notification.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/conf/notification.xml.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'portmanagement.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/conf/portmanagement.xml /opt/nokia/nmp/instances/pushserver/conf/portmanagement.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/conf/portmanagement.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/conf/portmanagement.xml.ORIG',
		require		=> Class['pushserver::install'],
	}

	exec { 'yahoo.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/pushserver/plugins/yahoo/yahoo.properties /opt/nokia/nmp/instances/pushserver/plugins/yahoo/yahoo.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/pushserver/plugins/yahoo/yahoo.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/pushserver/plugins/yahoo/yahoo.properties.ORIG',
		require		=> Class['pushserver::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/pushserver/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/pushserver/platform.env',
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
		path		=> '/opt/nokia/nmp/instances/pushserver/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/pushserver/application/configuration.xml',
		content		=> template("pushserver/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

	file { 'farm.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/pushserver/conf/farm.xml',
		content		=> template("pushserver/farm.xml-${unity_branch}.erb"),
		require		=> Exec['farm.xml.ORIG'],
	}

	file { 'notification.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/pushserver/conf/notification.xml',
		content		=> template("pushserver/notification.xml-${unity_branch}.erb"),
		require		=> Exec['notification.xml.ORIG'],
	}

	file { 'portmanagement.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/pushserver/conf/portmanagement.xml',
		content		=> template("pushserver/portmanagement.xml-${unity_branch}.erb"),
		require		=> Exec['portmanagement.xml.ORIG'],
	}

	file { 'caching.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/pushserver/conf/caching.xml',
		content		=> template("pushserver/caching.xml-${unity_branch}.erb"),
		require		=> Exec['caching.xml.ORIG'],
	}

	file { 'yahoo.properties':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/pushserver/plugins/yahoo/yahoo.properties',
		content		=> template("pushserver/yahoo.properties-${unity_branch}.erb"),
		require		=> Exec['yahoo.properties.ORIG'],
	}

} # End of class pushserver::config
