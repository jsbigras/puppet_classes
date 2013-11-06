# Class: li
# This module install the unity li and monit on the server.
#
# Parameters:
#
# $unity_branch: The unity branch number
# $unity_branch		= '1.0'
#
# $yum_server1: Yum server
# $yum_server = '172.16.36.101'
#
# $l_port_li: Listening port for the li.
# $l_port_li = '3080'
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
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
# class { li:
#	unity_branch		=> '1.0',
#	yum_server1		=> '172.16.36.101'
#	l_port_li		=> '3080',
#       int_vip_cluster         => '10.33.64.181',
#	db_master		=> 'tbd'
#	db_slave		=> 'tbd'
#	db_pwd			=> 'tbd'
#	sch_pwd			=> 'tbd'
#	sch_sql_col_tbl		=> 'tbd'
#	stage			=> post,
# }

class li (	$unity_branch		= '1.0',
		$yum_server1		= '172.16.36.101',
		$l_port_li		= '3080',
		$int_vip_cluster	= '10.33.64.181',
		$db_master		= 'tbd',
		$db_slave		= 'tbd',
		$db_pwd			= 'tbd',
		$sch_pwd		= 'tbd',
		$sch_sql_col_tbl	= [] ) {

	include li::install, li::config, li::service

} # End of class li
