# Class: cstore
# This module install the unity cstore and monit on the server.
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
# $l_port_cache: The port the cache server is listening to.
# $l_port_cache = '3001'
#
# $cache_primary: IP address of the primary cache server.
# $cache_primary = 'tbd'
#
# $cache_secondary: IP address of the secondary cache server.
# $cache_secondary = 'tbd'
#
# $cacheid_desc: Components which benefit from the cacheId.
# $cacheid_desc = []
#
# $cacheid_name: cacheId name
# $cacheid_name = []
#
# $cacheid_maxinmem: maxElementsInMemoryForCluster
# $cacheid_maxinmem = []
#
# $cacheid_verenabled: versioningEnabled
# $cacheid_verenabled = []
#
# $cacheid_hddpersist: hddPersistent off|synchronized|batched
# $cacheid_hddpersist = []
#
# $tokensmemmaxsize: This is the value for the token local cache on the Content Store server.
# $tokensmemmaxsize = '10000'
#
# $v_port_cstore_admin: Listening port for the Content Store admin interface.
# $v_port_cstore_admin = '3131'
#
# $l_port_cstore_mo: Listening port for the Content Store MO interface.
# $l_port_cstore_mo = '3130'
#
# $v_port_aaa_admin: Listening port for the AAA admin interface.
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
# class { cstore:
#	unity_branch		=> '1.0',
#	heap			=> '1024',
#	offheap			=> '1024',
#	port_snmp		=> '4000',
#	snmp_receiver_ip	=> '172.16.36.105',
#       l_port_cache		=> '3001',
#       cache_primary		=> 'tbd',
#       cache_secondary		=> 'tbd',
#       cacheid_desc		=> [],
#       cacheid_name		=> [],
#       cacheid_maxinmem	=> [],
#       cacheid_verenabled	=> [],
#       cacheid_hddpersist	=> [],
#       tokensmemmaxsize	=> '10000',
#	v_port_cstore_admin	=> '3131',
#	l_port_cstore_mo	=> '3130',
#	v_port_aaa_admin	=> '3023',
#	int_vip_cluster		=> 'tbd',
#	db_master		=> 'tbd'
#	db_slave		=> 'tbd'
#	db_pwd			=> 'tbd'
#	sch_pwd			=> 'tbd'
#	sch_sql_col_tbl		=> 'tbd'
#	stage			=> post,
# }

class cstore (	$unity_branch		= '1.0',
		$heap			= '1024',
		$offheap		= '1024',
		$port_snmp		= '4000',
		$snmp_receiver_ip	= '172.16.36.105',
		$l_port_cache		= '3001',
		$cache_primary		= 'tbd',
		$cache_secondary	= 'tbd',
		$cacheid_desc		= [],
		$cacheid_name		= [],
		$cacheid_maxinmem	= [],
		$cacheid_verenabled	= [],
		$cacheid_hddpersist	= [],
		$tokensmemmaxsize	= '10000',
		$v_port_cstore_admin	= '3131',
		$l_port_cstore_mo	= '3130',
		$v_port_aaa_admin	= '3023',
		$int_vip_cluster	= 'tbd',
		$db_master		= 'tbd',
		$db_slave		= 'tbd',
		$db_pwd			= 'tbd',
		$sch_pwd		= 'tbd',
		$sch_sql_col_tbl	= [] ) {

	include cstore::install, cstore::config#, cstore::service

} # End of class cstore
