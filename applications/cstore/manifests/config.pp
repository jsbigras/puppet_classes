# Class: cstore::config
# This module manages the configuration of the unity cstore on the server.
#

class cstore::config {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

	exec { 'platform.env.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/myriadstore/platform.env /opt/nokia/nmp/instances/myriadstore/platform.env.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/myriadstore/platform.env*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/myriadstore/platform.env.ORIG',
		require		=> Class['cstore::install'],
	}

	exec { 'platform.properties.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/myriadstore/platform.properties /opt/nokia/nmp/instances/myriadstore/platform.properties.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/myriadstore/platform.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/myriadstore/platform.properties.ORIG',
		require		=> Class['cstore::install'],
	}

	exec { 'configuration.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/myriadstore/myriadstore/configuration.xml /opt/nokia/nmp/instances/myriadstore/myriadstore/configuration.xml.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/myriadstore/myriadstore/configuration.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/myriadstore/myriadstore/configuration.xml.ORIG',
		require		=> Class['cstore::install'],
	}

	exec { 'persistence.xml.ORIG':
		command		=> 'cp -p /opt/nokia/nmp/instances/myriadstore/conf/persistence.xml /opt/nokia/nmp/instances/myriadstore/conf/persistence.xml.ORIG \
				&& su - ozimps -c \' dos2unix /opt/nokia/nmp/instances/myriadstore/conf/persistence.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/nokia/nmp/instances/myriadstore/conf/persistence.xml.ORIG',
		require		=> Class['cstore::install'],
	}

        exec { 'caching.xml.ORIG':
                command         => 'cp -p /opt/nokia/nmp/instances/myriadstore/conf/caching.xml /opt/nokia/nmp/instances/myriadstore/conf/caching.xml.ORIG \
                                && su - ozimps -c \'dos2unix /opt/nokia/nmp/instances/myriadstore/conf/caching.xml*\'',
                path            => ['/bin', '/usr/bin'],
                unless          => 'ls /opt/nokia/nmp/instances/myriadstore/conf/caching.xml.ORIG',
                require         => Class['cstore::install'],
        }

	augeas { 'platform.env':
		lens		=> 'Shellvars.lns',
		incl		=> '/opt/nokia/nmp/instances/myriadstore/platform.env',
		context		=> '/files/opt/nokia/nmp/instances/myriadstore/platform.env',
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
		path		=> '/opt/nokia/nmp/instances/myriadstore/platform.properties',
		content		=> template('platform/platform.properties.erb'),
		require		=> Exec['platform.properties.ORIG'],
	}

	file { 'configuration.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/myriadstore/myriadstore/configuration.xml',
		content		=> template("cstore/configuration.xml-${unity_branch}.erb"),
		require		=> Exec['configuration.xml.ORIG'],
	}

	file { 'persistence.xml':
		ensure		=> present,
		path		=> '/opt/nokia/nmp/instances/myriadstore/conf/persistence.xml',
		content		=> template("cstore/persistence.xml-${unity_branch}.erb"),
		require		=> Exec['persistence.xml.ORIG'],
	}

        file { 'caching.xml':
                ensure          => present,
                path            => '/opt/nokia/nmp/instances/myriadstore/conf/caching.xml',
                content         => template("cstore/caching.xml-${unity_branch}.erb"),
                require         => Exec['caching.xml.ORIG'],
        }

	exec { 'create_db':
		command		=> "mysql -uroot -p${db_pwd} -h${db_master} -e \"create database ${sch_sql_col_tbl[0]} character set latin1 collate latin1_bin;\"",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -uroot -psynchronica -h${db_master}",
		require		=> Class['cstore::install'],
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
		command		=> "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} < /opt/nokia/nmp/instances/myriadstore/myriadstore/_sql/${sch_sql_col_tbl[1]}",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} -e \"select ${sch_sql_col_tbl[2]} from ${sch_sql_col_tbl[3]};\"",
		require		=> Exec['grant_user2db'],
	}

} # End of class cstore::config
