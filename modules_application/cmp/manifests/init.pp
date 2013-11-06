# Class: cmp
# This module install the unity cmp and monit on the server.
#
# Parameters:
#
# $unity_branch: The unity branch number
# $unity_branch		= '1.0'
#
# $yum_server1: Yum server
# $yum_server = '172.16.36.101'
#
# $l_port_cmp: Listening port for the cmp.
# $l_port_cmp = '3032'
#
# $v_port_cstore_admin: Listening port for the admin interface of Content Store.
# $v_port_cstore_admin = '3031'
#
# $v_port_aaa_admin: Listening port for the interface of AAA.
# $v_port_aaa_admin = '3023'
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
# class { cmp:
#	unity_branch		=> '1.0',
#	yum_server1		=> '172.16.36.101'
#	l_port_cmp		=> '3032',
#	v_port_cstore_admin     => '3031',
#	v_port_aaa_admin        => '3023',
#       int_vip_cluster         => '10.33.64.181',
#	db_master		=> 'tbd'
#	db_slave		=> 'tbd'
#	db_pwd			=> 'tbd'
#	sch_pwd			=> 'tbd'
#	sch_sql_col_tbl		=> 'tbd'
#	stage			=> post,
# }

class cmp (	$unity_branch		= '1.0',
		$yum_server1		= '172.16.36.101',
		$l_port_cmp		= '3032',
		$v_port_cstore_admin    = '3031',
		$v_port_aaa_admin       = '3023',
		$int_vip_cluster	= '10.33.64.181',
		$db_master		= 'tbd',
		$db_slave		= 'tbd',
		$db_pwd			= 'tbd',
		$sch_pwd		= 'tbd',
		$sch_sql_col_tbl	= [] ) {

	include cmp::install, cmp::config#, cmp::service

} # End of class cmp
