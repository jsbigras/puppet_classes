# Class: sngtw::config
# This module manages the configuration of the unity sngtw on the server.
#

class sngtw::config {

	$tempo = "$::hostname"
	$prefix = inline_template("<%= %x{echo -n $tempo | sed 's/-[0-9][0-9].*//' | sed 's/[0-9][0-9].*//'} %>")

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/sngtw/platform.env /opt/nokia/nmp/instances/sngtw/platform.env.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/sngtw/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/sngtw/platform.env.ORIG',
		require		=> Class['sngtw::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/sngtw/platform.properties /opt/nokia/nmp/instances/sngtw/platform.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/sngtw/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/sngtw/platform.properties.ORIG',
		require		=> Class['sngtw::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/sngtw/sngtw/configuration.xml /opt/nokia/nmp/instances/sngtw/sngtw/configuration.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/sngtw/sngtw/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/sngtw/sngtw/configuration.xml.ORIG',
		require		=> Class['sngtw::install'],
	}

	exec { 'caching.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/sngtw/conf/caching.xml /opt/nokia/nmp/instances/sngtw/conf/caching.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/sngtw/conf/caching.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/sngtw/conf/caching.xml.ORIG',
		require		=> Class['sngtw::install'],
	}

	exec { 'notification.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/sngtw/conf/notification.xml /opt/nokia/nmp/instances/sngtw/conf/notification.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/sngtw/conf/notification.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/sngtw/conf/notification.xml.ORIG',
		require		=> Class['sngtw::install'],
	}

	exec { 'transcoding.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/sngtw/conf/transcoding.xml /opt/nokia/nmp/instances/sngtw/conf/transcoding.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/sngtw/conf/transcoding.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/sngtw/conf/transcoding.xml.ORIG',
		require		=> Class['sngtw::install'],
	}

	exec { 'yahoo.properties.ORIG':
		command		=> 'cp -p /opt/nokia/plugins/yahoo/yahoo.properties /opt/nokia/plugins/yahoo/yahoo.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/plugins/yahoo/yahoo.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/plugins/yahoo/yahoo.properties.ORIG',
		require		=> Class['sngtw::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/sngtw/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/sngtw/platform.env',
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
		path		=> '/opt/nokia/nmp/instances/sngtw/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/sngtw/sngtw/configuration.xml',
		content		=> template("sngtw/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

	file { 'caching.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/sngtw/conf/caching.xml',
		content		=> template("sngtw/caching.xml-${unity_branch}.erb"),
		require		=> Exec['caching.xml.ORIG'],
	}

	file { 'notification.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/sngtw/conf/notification.xml',
		content		=> template("sngtw/notification.xml-${unity_branch}.erb"),
		require		=> Exec['notification.xml.ORIG'],
	}

	file { 'transcoding.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/sngtw/conf/transcoding.xml',
		content		=> template("sngtw/transcoding.xml-${unity_branch}.erb"),
		require		=> Exec['transcoding.xml.ORIG'],
	}

	file { 'yahoo.properties':
		ensure		=> present,
		path		=> '/opt/nokia/plugins/yahoo/yahoo.properties',
		content		=> template("sngtw/yahoo.properties-${unity_branch}.erb"),
		require		=> Exec['yahoo.properties.ORIG'],
	}

	file { '/var/log/nokia/nmp/traces':
		ensure		=> directory,
		require		=> Class['sngtw::install'],
	}

} # End of class sngtw::config
