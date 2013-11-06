# Class: nmptaskmanager
# This module install the unity nmptaskmanager and monit on the server.
#
# Parameters:
#
# $unity_branch: The unity branch number
# $unity_branch		= '1.0'
#
# $heap: The unity component heap value
# $heap			= '1024'
#
# $offheap: The unity component offheap value
# $offheap		= '1024'
#
# $port_snmp: The unity component SNMP listening port
# $port_snmp = '4000'
#
# $snmp_receiver_ip: The IP where we send the trap
# $snmp_receiver_ip = '<nagios server ip>'
#
# $v_port_tm: Listening port for the TM.
# $v_port_tm = '3026'
#
# $taskmanager_cluste: Array composed of all the TM IPs in the cluster.
# $taskmanager_cluster    = 'tbd'
#
# $pushserver_cluster: Array composed of all the PS IPs in the cluster.
# $pushserver_cluster     = 'tbd'
#
# $l_port_farm: Port used by PS and TM for the farm
# $l_port_farm = '3020'
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
# Sample usage:
#
# class { nmptaskmanager:
#	unity_branch		=> '1.0',
#	heap			=> '1024',
#	offheap			=> '1024',
#	port_snmp		=> '4000',
#	snmp_receiver_ip	=> '172.16.36.105',
#	v_port_tm		=> '3026',
#	taskmanager_cluster	=> 'tbd',
#	pushserver_cluster	=> 'tbd',
#	l_port_farm		=> '3020',
#	db_master		=> 'tbd'
#	db_slave		=> 'tbd'
#	db_pwd			=> 'tbd'
#	sch_pwd			=> 'tbd'
#	sch_sql_col_tbl		=> 'tbd'
#	stage			=> post,
# }

class nmptaskmanager (	$unity_branch		= '1.0',
			$heap			= '1024',
			$offheap		= '1024',
			$port_snmp		= '4000',
			$snmp_receiver_ip	= '172.16.36.105',
			$v_port_tm		= '3026',
			$taskmanager_cluster	= 'tbd',
			$pushserver_cluster	= 'tbd',
			$l_port_farm		= '3020',
			$db_master		= 'tbd',
			$db_slave		= 'tbd',
			$db_pwd			= 'tbd',
			$sch_pwd		= 'tbd',
			$sch_sql_col_tbl	= [] ) {

	include nmptaskmanager::install, nmptaskmanager::config, nmptaskmanager::service

} # End of class nmptaskmanager
