# Class: imps::app
# This module install the imps application component on the server.
#
# Parameters:
#
# $branch: The imps branch number
# $branch = '1.0'
#
# $carrier: Carrier name supported.
# $carrier = 'airtel'
#
# $yum_server1: Yum server
# $yum_server = '172.16.36.101'
#
# $path: The path were we can find the carier directory.
# $path = '/opt/colibria'
#
# $heap: The imps component heap value
# $heap = '1024'
#
# $db_master: Master DB.
# $db_master = 'tbd'
#
# $db_slave: Slave DB.
# $db_slave = 'tbd'
#
# $db_pwd: Database root password.
# $db_pwd = 'tbd'
#
# $sch_pwd: Schema password.
# $sch_pwd = 'tbd'
#
# $sch_sql_col_tbl: Schema name, script, colomn and table.
# $sch_sql_col_tbl = []
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
#
# $multicastip: Multicast IPs used by the application.
# $multicastip = []
#
# $multicastport: Multicast Ports used by the application. 
# $multicastport = []
#
# Sample usage:
#
# class { 'imps::app':
#	branch		=> '1.0',
#	carrier		=> 'airtel',
#       yum_server1     => '172.16.36.101',
#	path		=> '/opt/colibria',
#	heap		=> '1024',
#	db_master	=> 'tbd',
#	db_slave	=> 'tbd',
#	db_pwd		=> 'tbd',
#	sch_pwd		=> 'tbd',
#	sch_sql_col_tbl	=> [],
#	int_vip_cluster => 'tbd',
#	multicastip	=> [],
#	multicastport	=> [],
#	stage		=> post,
# }

class imps::app (	$branch			= '1.0',
			$carrier		= 'airtel',
                        $yum_server1            = '172.16.36.101',
			$path			= '/opt/colibria',
			$heap			= '1024',
			$db_master		= 'tbd',
			$db_slave		= 'tbd',
			$db_pwd			= 'tbd',
			$sch_pwd		= 'tbd',
			$sch_sql_col_tbl	= [],
			$int_vip_cluster	= 'tbd',
			$multicastip		= [],
			$multicastport		= [] ) {
 
# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0755,
	}

# Install Application
        exec { "appserver-${branch}.tar.gz":
                command         => "wget http://${yum_server1}/yum/Application/${branch}/imps/appserver-${branch}-${carrier}.tar.gz",
                path            => ['/bin', '/usr/bin'],
		cwd		=> "${path}/${carrier}/",
                unless          => "ls ${path}/${carrier}/appserver-${branch}-${carrier}.tar.gz",
        }

        exec { 'untar_app':
                command         => "tar xzvf appserver-${branch}-${carrier}.tar.gz \
				&& mv `ls | grep appserver-${branch} | grep -v 'tar.gz'` appserver-${branch} \
				&& chown -R root:root appserver-${branch} \
				&& rm -f log/* \
				&& rm -f appserver-${branch}/logs/* \
				&& rm -f appserver-${branch}/*.log \
				&& find appserver-${branch} -name '.svn' -type d | xargs rm -rf",
                path            => ['/bin', '/usr/bin'],
		cwd		=> "${path}/${carrier}/",
                unless          => "ls ${path}/${carrier}/appserver-${branch}",
                require         => Exec["appserver-${branch}.tar.gz"],
        }

	file { "${path}/${carrier}/current-app":
		ensure		=> link,
		target		=> "${path}/${carrier}/appserver-${branch}",
		require		=> Exec['untar_app'],
	}

	exec { 'app_vmoptions.ORIG':
		command		=> "cp -p ${path}/${carrier}/current-app/common/conf/vmoptions ${path}/${carrier}/current-app/common/conf/vmoptions.ORIG",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "ls ${path}/${carrier}/current-app/common/conf/vmoptions.ORIG",
		require         => File["${path}/${carrier}/current-app"],
	}

	exec { 'message-bus.properties.ORIG':
		command		=> "cp -p ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties.ORIG",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "ls ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties.ORIG",
		require         => File["${path}/${carrier}/current-app"],
	}

	exec { 'persistence.properties.ORIG':
		command		=> "cp -p ${path}/${carrier}/current-app/colibria/classes/persistence.properties ${path}/${carrier}/current-app/colibria/classes/persistence.properties.ORIG",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "ls ${path}/${carrier}/current-app/colibria/classes/persistence.properties.ORIG",
		require         => File["${path}/${carrier}/current-app"],
	}

	exec { 'app_vmoptions':
		command		=> "sed -i -e \"s/-Xms.*m/-Xms${heap}m/\" ${path}/${carrier}/current-app/common/conf/vmoptions \
				&& sed -i -e \"s/-Xmx.*m/-Xmx${heap}m/\" ${path}/${carrier}/current-app/common/conf/vmoptions",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "grep -i \"Xms${heap}m\" ${path}/${carrier}/current-app/common/conf/vmoptions \
				&& grep -i \"Xmx${heap}m\" ${path}/${carrier}/current-app/common/conf/vmoptions",
		require         => Exec['app_vmoptions.ORIG'],
	}

        exec { 'app_jolokia':
                command         => "echo \"-javaagent:/opt/jolokia/jolokia-jvm-1.1.1-agent.jar=port=17706,host=`hostname -i`,policyLocation=file:///opt/jolokia/jolokia-access.xml\" >> ${path}/${carrier}/current-app/common/conf/vmoptions",
                path            => ['/bin', '/usr/bin'],
                unless          => "grep -i \"jolokia\" ${path}/${carrier}/current-app/common/conf/vmoptions",
                require         => Exec['app_vmoptions.ORIG'],
        }

	exec { 'message-bus.properties':
		command		=> "sed -i -e \"s/com.colibria.bus.messageBusName=.*/com.colibria.bus.messageBusName=${carrier}/\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& sed -i -e \"s/jgroups.colibria-message-bus-tcp.mcast_addr=.*/jgroups.colibria-message-bus-tcp.mcast_addr=${multicastip[0]}/\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& sed -i -e \"s/jgroups.colibria-message-bus-tcp-hashtable.mcast_addr=.*/jgroups.colibria-message-bus-tcp-hashtable.mcast_addr=${multicastip[1]}/\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& sed -i -e \"s/jgroups.colibria-message-bus-tcp.mcast_port=.*/jgroups.colibria-message-bus-tcp.mcast_port=${multicastport[0]}/\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& sed -i -e \"s/jgroups.colibria-message-bus-tcp-hashtable.mcast_port=.*/jgroups.colibria-message-bus-tcp-hashtable.mcast_port=${multicastport[1]}/\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "grep -i \"com.colibria.bus.messageBusName=${carrier}\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& grep -i \"jgroups.colibria-message-bus-tcp.mcast_addr=${multicastip[0]}\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& grep -i \"jgroups.colibria-message-bus-tcp-hashtable.mcast_addr=${multicastip[1]}\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& grep -i \"jgroups.colibria-message-bus-tcp.mcast_port=${multicastport[0]}\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties \
				&& grep -i \"jgroups.colibria-message-bus-tcp-hashtable.mcast_port=${multicastport[1]}\" ${path}/${carrier}/current-app/colibria/classes/cust/message-bus.properties",
		require         => Exec['message-bus.properties.ORIG'],
	}

	exec { 'persistence.properties':
		command		=> "sed -i -e \"s/jdbc.url=jdbc:mysql:\/\/.*:3306\/.*?/jdbc.url=jdbc:mysql:\/\/${int_vip_cluster}:3306\/${sch_sql_col_tbl[0]}?/\" ${path}/${carrier}/current-app/colibria/classes/persistence.properties \
				&& sed -i -e \"s/jdbc.username=.*/jdbc.username=${sch_sql_col_tbl[0]}/\" ${path}/${carrier}/current-app/colibria/classes/persistence.properties \
				&& sed -i -e \"s/jdbc.password=.*/jdbc.password=${sch_pwd}/\" ${path}/${carrier}/current-app/colibria/classes/persistence.properties",
		path		=> ['/bin', '/usr/bin'],
		unless		=> [
				"grep -i \"${int_vip_cluster}\" ${path}/${carrier}/current-app/colibria/classes/persistence.properties \
				&& grep -i \"${sch_pwd}\" ${path}/${carrier}/current-app/colibria/classes/persistence.properties \
				&& grep -i \"${sch_sql_col_tbl[0]}\" ${path}/${carrier}/current-app/colibria/classes/persistence.properties"
				],
		require         => Exec['persistence.properties.ORIG'],
	}

	exec { 'create_db':
		command         => "mysql -uroot -p${db_pwd} -h${db_master} -e \"create database ${sch_sql_col_tbl[0]} character set latin1 collate latin1_bin;\"",
		path            => ['/bin', '/usr/bin'],
		unless          => "mysql ${sch_sql_col_tbl[0]} -uroot -psynchronica -h${db_master}",
		require         => [
				Class['mysql'],
				File["${path}/${carrier}/current-app"],
				],
	}

	exec { 'create_user':
		command         => "mysql -uroot -p${db_pwd} -h${db_master} -e \"create user ${sch_sql_col_tbl[0]}@'%' identified by '${sch_pwd}';\"",
		path            => ['/bin', '/usr/bin'],
		unless          => "mysql -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master}",
		require         => Exec['create_db'],
	}

	exec { 'grant_user2db':
		command         => "mysql -uroot -p${db_pwd} -h${db_master} -e \"grant all on ${sch_sql_col_tbl[0]}.* to ${sch_sql_col_tbl[0]}@'%' identified by '${sch_pwd}' with grant option;\";mysql -uroot -p${db_pwd} -h${db_master} -e \"grant select,insert,update on mysql.proc to ${sch_sql_col_tbl[0]}@'%' identified by '${sch_pwd}';\"",
		path            => ['/bin', '/usr/bin'],
		unless          => "mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master}",
		require         => Exec['create_user'],
	}

} # End of class imps::app
