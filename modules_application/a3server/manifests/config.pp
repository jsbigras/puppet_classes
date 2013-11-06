# Class: a3server::config
# This module manages the configuration of the unity a3server on the server.
#

class a3server::config {

        $tempo = "$::hostname"
        $prefix = inline_template("<%= %x{echo -n $tempo | sed 's/-[0-9][0-9].*//' | sed 's/[0-9][0-9].*//'} %>")

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/platform.env /opt/nokia/nmp/instances/a3server/platform.env.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/platform.env.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/platform.properties /opt/nokia/nmp/instances/a3server/platform.properties.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/platform.properties.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'application.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/a3server/application.xml /opt/nokia/nmp/instances/a3server/a3server/application.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/a3server/application.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/a3server/application.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/a3server/configuration.xml /opt/nokia/nmp/instances/a3server/a3server/configuration.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/a3server/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/a3server/configuration.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'bouncer-codecs.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/a3server/bouncer-codecs.xml /opt/nokia/nmp/instances/a3server/a3server/bouncer-codecs.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/a3server/bouncer-codecs.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/a3server/bouncer-codecs.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'country-codes.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/a3server/country-codes.xml /opt/nokia/nmp/instances/a3server/a3server/country-codes.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/a3server/country-codes.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/a3server/country-codes.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'msisdn-validators.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/a3server/msisdn-validators.xml /opt/nokia/nmp/instances/a3server/a3server/msisdn-validators.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/a3server/msisdn-validators.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/a3server/msisdn-validators.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'caching.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/conf/caching.xml /opt/nokia/nmp/instances/a3server/conf/caching.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/conf/caching.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/conf/caching.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'notification.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/conf/notification.xml /opt/nokia/nmp/instances/a3server/conf/notification.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/conf/notification.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/conf/notification.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	exec { 'persistence.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/a3server/conf/persistence.xml /opt/nokia/nmp/instances/a3server/conf/persistence.xml.ORIG \
				&& su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/a3server/conf/persistence.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/a3server/conf/persistence.xml.ORIG',
		require		=> Class['a3server::install'],
	}

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/a3server/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/a3server/platform.env',
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
		path		=> '/opt/nokia/nmp/instances/a3server/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'application.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/a3server/application.xml',
		content		=> template("a3server/application.xml-${unity_branch}.erb"),
		require		=> Exec['application.xml.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/a3server/configuration.xml',
		content		=> template("a3server/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

	file { 'bouncer-codecs.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/a3server/bouncer-codecs.xml',
		content		=> template("a3server/bouncer-codecs.xml-${unity_branch}.erb"),
		require		=> Exec['bouncer-codecs.xml.ORIG'],
	}

	file { 'country-codes.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/a3server/country-codes.xml',
		source		=> 'puppet:///modules/a3server/country-codes.xml',
		require		=> Exec['country-codes.xml.ORIG'],
	}

	file { 'msisdn-validators.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/a3server/msisdn-validators.xml',
		content		=> template("a3server/msisdn-validators.xml-${unity_branch}.erb"),
		require		=> Exec['msisdn-validators.xml.ORIG'],
	}

	file { 'notification.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/conf/notification.xml',
		content		=> template("a3server/notification.xml-${unity_branch}.erb"),
		require		=> Exec['notification.xml.ORIG'],
	}

	file { 'caching.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/conf/caching.xml',
		content		=> template("a3server/caching.xml-${unity_branch}.erb"),
		require		=> Exec['caching.xml.ORIG'],
	}

	file { 'persistence.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/a3server/conf/persistence.xml',
		content		=> template("a3server/persistence.xml-${unity_branch}.erb"),
		require		=> Exec['persistence.xml.ORIG'],
	}

	exec { 'create_db':
		command		=> "mysql -uroot -p${db_pwd} -h${db_master} -e \"create database ${sch_sql_col_tbl[0]} character set latin1 collate latin1_bin;\"",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -uroot -psynchronica -h${db_master}",
		require		=> Class['a3server::install'],
	}

	exec { 'create_user':
		command		=> "mysql -uroot -p${db_pwd} -h${db_master} -e \"create user ${sch_sql_col_tbl[0]}@'%' identified by '${sch_pwd}';\"",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master}",
		require		=> Exec['create_db'],
	}

	exec { 'grant_user2db':
		command		=> "mysql -uroot -p${db_pwd} -h${db_master} -e \"grant all on ${sch_sql_col_tbl[0]}.* to ${sch_sql_col_tbl[0]}@'%' identified by '${sch_pwd}' with grant option;\";mysql -uroot -p${db_pwd} -h${db_master} -e \"grant select,insert,update on mysql.proc to ${sch_sql_col_tbl[0]}@'%' identified by '${sch_pwd}';\"",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master}",
		require		=> Exec['create_user'],
	}

	exec { 'create_tables':
		command		=> "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} < /opt/nokia/nmp/instances/a3server/a3server/_sql/${sch_sql_col_tbl[1]}",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} -e \"select ${sch_sql_col_tbl[2]} from ${sch_sql_col_tbl[3]};\"",
		require		=> Exec['grant_user2db'],
	}

} # End of class a3server::config
