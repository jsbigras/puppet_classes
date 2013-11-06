# Class: nmpcache
# This module install the unity nmpcache and monit on the server.
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
# Sample usage:
#
# class { nmpcache:
#	unity_branch		=> '1.0',
#	heap			=> '1024',
#	offheap			=> '1024',
#	port_snmp		=> '4000',
#	snmp_receiver_ip	=> '172.16.36.105',
#	l_port_cache		=> '3001',
#	cache_primary		=> 'tbd',
#	cache_secondary		=> 'tbd',
#	cacheid_desc		=> [],
#	cacheid_name		=> [],
#	cacheid_maxinmem	=> [],
#	cacheid_verenabled	=> [],
#	cacheid_hddpersist	=> [],
#	stage			=> post,
# }

class nmpcache (	$unity_branch		= '1.0',
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
			$cacheid_hddpersist	= [] ) {

	include nmpcache::install, nmpcache::config, nmpcache::service

} # End of class nmpcache
