# Class: li::config
# This module manages the configuration of the unity li on the server.
#

class li::config {

# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

# Install Tomcat, pre-req for li
        exec { 'apache-tomcat.tar':
                command         => "wget http://${yum_server1}/yum/Application/${unity_branch}/li/apache-tomcat-7.0.41.tar",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/",
                unless          => "ls /opt/apache-tomcat-7.0.41.tar",
		require		=> Class['li::install'],
        }

        exec { 'untar_tomcat':
                command         => "tar xvf /opt/apache-tomcat-7.0.41.tar;chown -R ozimps:ozimps /opt/apache-tomcat-7.0.41",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/",
                unless          => "ls /opt/apache-tomcat-7.0.41",
                require         => Exec['apache-tomcat.tar'],
	}

        file { '/opt/tomcat':
                ensure          => link,
                target          => "/opt/apache-tomcat-7.0.41",
                require         => Exec['untar_tomcat'],
        }

        file { '/opt/tomcat/webapps/lawful':
                ensure          => directory,
                require         => File['/opt/tomcat'],
        }

        exec { 'lawful.war':
                command         => "wget http://${yum_server1}/yum/Application/${unity_branch}/li/lawful.war",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/tomcat/webapps/lawful",
                unless          => "ls /opt/tomcat/webapps/lawful/lawful.war",
                require         => File['/opt/tomcat/webapps/lawful'],
        }

        exec { 'unzip_lawful':
                command         => "unzip /opt/tomcat/webapps/lawful/lawful.war;chown -R ozimps:ozimps /opt/tomcat/webapps/lawful/*",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/tomcat/webapps/lawful",
                unless          => "ls /opt/apache-tomcat-7.0.41/webapps/lawful/WEB-INF",
                require         => Exec['lawful.war'],
        }

	exec { 'persistence.properties.ORIG':
		command		=> 'cp -p /opt/tomcat/webapps/lawful/WEB-INF/classes/persistence.properties /opt/tomcat/webapps/lawful/WEB-INF/classes/persistence.properties.ORIG \
				&& su - ozimps -c \' dos2unix /opt/tomcat/webapps/lawful/WEB-INF/classes/persistence.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/tomcat/webapps/lawful/WEB-INF/classes/persistence.properties.ORIG',
		require		=> Exec['unzip_lawful'],
	}

	exec { 'server.xml.ORIG':
		command		=> 'cp -p /opt/tomcat/conf/server.xml /opt/tomcat/conf/server.xml.ORIG \
				&& su - ozimps -c \' dos2unix /opt/tomcat/conf/server.xml*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/tomcat/conf/server.xml.ORIG',
		require		=> Exec['unzip_lawful'],
	}

	file { 'persistence.properties':
		ensure		=> present,
		path		=> '/opt/tomcat/webapps/lawful/WEB-INF/classes/persistence.properties',
		content		=> template('li/persistence.properties.erb'),
		require		=> Exec['persistence.properties.ORIG'],
	}

	file { 'server.xml':
		ensure		=> present,
		path		=> '/opt/tomcat/conf/server.xml',
		content		=> template('li/server.xml.erb'),
		require		=> Exec['server.xml.ORIG'],
	}

# Create lawfull directories and config servers.cfg
        file { '/opt/myriad':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/traces':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/suspects':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/audit':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/log':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/servers':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/temp':
                ensure          => directory,
        }

        file { '/opt/myriad/lawful/temp/export':
                ensure          => directory,
        }

	file { '/opt/myriad/lawful/servers/servers.cfg':
		ensure		=> present,
		content		=> template('li/servers.cfg.erb'),
	}

# Create DB and User in the cluster database
	exec { 'create_db':
		command		=> "mysql -uroot -p${db_pwd} -h${db_master} -e \"create database ${sch_sql_col_tbl[0]} character set latin1 collate latin1_bin;\"",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -uroot -psynchronica -h${db_master}",
		require		=> Class['li::install'],
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

} # End of class li::config
