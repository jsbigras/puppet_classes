# Class: cmp::config
# This module manages the configuration of the unity cmp on the server.
#

class cmp::config {

# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> ozimps,
		group		=> ozimps,
		mode		=> 0644,
	}

# Install Tomcat, pre-req for cmp
        exec { 'apache-tomcat.tar':
                command         => "wget http://${yum_server1}/yum/Application/${unity_branch}/cmp/apache-tomcat-7.0.41.tar",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/",
                unless          => "ls /opt/apache-tomcat-7.0.41.tar",
		require		=> Class['cmp::install'],
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

        file { '/opt/tomcat/webapps/cmp':
                ensure          => directory,
                require         => File['/opt/tomcat'],
        }

        exec { 'cmp.war':
                command         => "wget http://${yum_server1}/yum/Application/${unity_branch}/cmp/cmp.war",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/tomcat/webapps/cmp",
                unless          => "ls /opt/tomcat/webapps/cmp/cmp.war",
                require         => File['/opt/tomcat/webapps/cmp'],
        }

        exec { 'unzip_cmp':
                command         => "unzip /opt/tomcat/webapps/cmp/cmp.war;chown -R ozimps:ozimps /opt/tomcat/webapps/cmp/*",
                path            => ['/bin', '/usr/bin'],
                cwd             => "/opt/tomcat/webapps/cmp",
                unless          => "ls /opt/apache-tomcat-7.0.41/webapps/cmp/WEB-INF",
                require         => Exec['cmp.war'],
        }

	exec { 'content-store.properties.ORIG':
		command		=> 'cp -p /opt/tomcat/webapps/cmp/WEB-INF/classes/content-store.properties /opt/tomcat/webapps/cmp/WEB-INF/classes/content-store.properties.ORIG \
				&& su - ozimps -c \' dos2unix /opt/tomcat/webapps/cmp/WEB-INF/classes/content-store.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/tomcat/webapps/cmp/WEB-INF/classes/content-store.properties.ORIG',
		require		=> Exec['unzip_cmp'],
	}

	exec { 'persistence.properties.ORIG':
		command		=> 'cp -p /opt/tomcat/webapps/cmp/WEB-INF/classes/persistence.properties /opt/tomcat/webapps/cmp/WEB-INF/classes/persistence.properties.ORIG \
				&& su - ozimps -c \' dos2unix /opt/tomcat/webapps/cmp/WEB-INF/classes/persistence.properties*\'',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /opt/tomcat/webapps/cmp/WEB-INF/classes/persistence.properties.ORIG',
		require		=> Exec['unzip_cmp'],
	}

        exec { 'server.xml.ORIG':
                command         => 'cp -p /opt/tomcat/conf/server.xml /opt/tomcat/conf/server.xml.ORIG \
                                && su - ozimps -c \' dos2unix /opt/tomcat/conf/server.xml*\'',
                path            => ['/bin', '/usr/bin'],
                unless          => 'ls /opt/tomcat/conf/server.xml.ORIG',
                require         => Exec['unzip_cmp'],
        }

	file { 'content-store.properties':
		ensure		=> present,
		path		=> '/opt/tomcat/webapps/cmp/WEB-INF/classes/content-store.properties',
		content		=> template("cmp/content-store.properties-${unity_branch}.erb"),
		require		=> Exec['content-store.properties.ORIG'],
	}

	file { 'persistence.properties':
		ensure		=> present,
		path		=> '/opt/tomcat/webapps/cmp/WEB-INF/classes/persistence.properties',
		content		=> template("cmp/persistence.properties-${unity_branch}.erb"),
		require		=> Exec['persistence.properties.ORIG'],
	}

        file { 'server.xml':
                ensure          => present,
                path            => '/opt/tomcat/conf/server.xml',
                content         => template("cmp/server.xml-${unity_branch}.erb"),
                require         => Exec['server.xml.ORIG'],
        }

# Create cmp directories
        file { '/opt/myriad':
                ensure          => directory,
        }

        file { '/opt/myriad/cmp':
                ensure          => directory,
        }

        file { '/opt/myriad/cmp/audit':
                ensure          => directory,
        }

        file { '/opt/myriad/cmp/log':
                ensure          => directory,
        }

        file { '/opt/myriad/cmp/temp':
                ensure          => directory,
        }

        file { '/home/ozimps/SSL':
                ensure          => directory,
        }

# Create Tomcat 6 sefl-signed keystore
        exec { 'create_keystore':
                command         => 'keytool -genkey -alias tomcat -keyalg RSA -keysize 1024 -dname "CN=Unknown,OU=Myriadgroup,O=Messenger,L=Montreal,ST=QC,C=CA" -keypass 123456 -keystore ./keystore -storepass 123456',
                path            => ['/bin','/usr/java/jre1.7.0_25/bin'],
                cwd             => '/home/ozimps/SSL',
                unless          => 'ls /home/ozimps/SSL/keystore',
                require         => File['/home/ozimps/SSL'],
	}

# Create DB and User in the cluster database
	exec { 'create_db':
		command		=> "mysql -uroot -p${db_pwd} -h${db_master} -e \"create database ${sch_sql_col_tbl[0]} character set latin1 collate latin1_bin;\"",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "mysql ${sch_sql_col_tbl[0]} -uroot -psynchronica -h${db_master}",
		require		=> Class['cmp::install'],
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
                command         => "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} < /opt/tomcat/webapps/cmp/WEB-INF/classes/scripts/${sch_sql_col_tbl[1]}",
                path            => ['/bin', '/usr/bin'],
                unless          => "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} -e \"select ${sch_sql_col_tbl[2]} from ${sch_sql_col_tbl[3]};\"",
                require         => Exec['grant_user2db'],
        }

#        exec { 'populate_tables':
#                command         => "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} < /opt/tomcat/webapps/cmp/WEB-INF/classes/scripts/setup.sql",
#                path            => ['/bin', '/usr/bin'],
##                unless          => "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} -e \"select ${sch_sql_col_tbl[2]} from ${sch_sql_col_tbl[3]};\"",
#                require         => Exec['grant_user2db'],
#        }

} # End of class cmp::config