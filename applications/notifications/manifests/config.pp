# Class: notifications::config
# This module manages the configuration of the unity notifications on the server.
#

class notifications::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/notifications/platform.env /opt/nokia/nmp/instances/notifications/platform.env.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/notifications/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/notifications/platform.env.ORIG',
		require		=> Class['notifications::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/notifications/platform.properties /opt/nokia/nmp/instances/notifications/platform.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/notifications/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/notifications/platform.properties.ORIG',
		require		=> Class['notifications::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/notifications/notifications/configuration.xml /opt/nokia/nmp/instances/notifications/notifications/configuration.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/notifications/notifications/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/notifications/notifications/configuration.xml.ORIG',
		require		=> Class['notifications::install'],
	}

	exec { 'caching.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/notifications/conf/caching.xml /opt/nokia/nmp/instances/notifications/conf/caching.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/notifications/conf/caching.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/notifications/conf/caching.xml.ORIG',
		require		=> Class['notifications::install'],
	}

	exec { 'notification.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/notifications/conf/notification.xml /opt/nokia/nmp/instances/notifications/conf/notification.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/notifications/conf/notification.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/notifications/conf/notification.xml.ORIG',
		require		=> Class['notifications::install'],
	}

	exec { 'gcm.properties.ORIG':
		command		=> 'cp -p /opt/nokia/plugins/ns_plugin_gcm/gcm.properties /opt/nokia/plugins/ns_plugin_gcm/gcm.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/plugins/ns_plugin_gcm/gcm.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/plugins/ns_plugin_gcm/gcm.properties.ORIG',
		require		=> Class['notifications::install'],
	}

	exec { 'kannel.properties.ORIG':
		command		=> 'cp -p /opt/nokia/plugins/ns_plugin_kannel/kannel.properties /opt/nokia/plugins/ns_plugin_kannel/kannel.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/plugins/ns_plugin_kannel/kannel.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/plugins/ns_plugin_kannel/kannel.properties.ORIG',
		require		=> Class['notifications::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/notifications/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/notifications/platform.env',
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
		path		=> '/opt/nokia/nmp/instances/notifications/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/notifications/notifications/configuration.xml',
		content		=> template("notifications/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

	file { 'caching.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/notifications/conf/caching.xml',
		content		=> template("notifications/caching.xml-${unity_branch}.erb"),
		require		=> Exec['caching.xml.ORIG'],
	}

	file { 'notification.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/notifications/conf/notification.xml',
		content		=> template("notifications/notification.xml-${unity_branch}.erb"),
		require		=> Exec['notification.xml.ORIG'],
	}

	file { 'gcm.properties':
		ensure		=> present,
		path		=> '/opt/nokia/plugins/ns_plugin_gcm/gcm.properties',
		content		=> template("notifications/gcm.properties-${unity_branch}.erb"),
		require		=> Exec['gcm.properties.ORIG'],
	}

	file { 'kannel.properties':
		ensure		=> present,
		path		=> '/opt/nokia/plugins/ns_plugin_kannel/kannel.properties',
		content		=> template("notifications/kannel.properties-${unity_branch}.erb"),
		require		=> Exec['kannel.properties.ORIG'],
	}

	# Add the notification hotfix 1 to unity 2.3
	if $unity_branch == "2.3" {
		exec { 'platform.sh.bak.b4hf01':
			command		=> 'cp -p /opt/nokia/nmp/bin/platform.sh /opt/nokia/nmp/bin/platform.sh.bak.b4hf01',
			path		=> ['/bin', '/usr/bin'],
			unless		=> 'ls /opt/nokia/nmp/bin/platform.sh.bak.b4hf01',
			require		=> Class['notifications::install'],
		}

		file { "platform.sh-2.3.hf01":
			ensure		=> present,
			path		=> '/opt/nokia/nmp/bin/platform.sh',
			source		=> "puppet:///modules/notifications/platform.sh-${unity_branch}.hf01",
			mode		=> 0777,
			require		=> Exec['platform.sh.bak.b4hf01'],
		}
	} # end of if ${unity_branch} == '2.3' {

} # End of class notifications::config
