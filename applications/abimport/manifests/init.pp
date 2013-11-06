# Class: abimport
# This module install the unity abimport and monit on the server.
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
# $l_port_abimport_mo: Listening port for the Address Book import MO interface.
# $l_port_abimport_mo = '3030'
#
# $v_port_imps_be: Listening port for the IMPS BE interface.
# $v_port_imps_be = '3013'
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
#
# Sample usage:
#
# class { abimport:
#	unity_branch		=> '1.0',
#	heap			=> '1024',
#	offheap			=> '1024',
#	port_snmp		=> '4000',
#	snmp_receiver_ip	=> '172.16.36.105',
#	l_port_abimport_mo	=> '3030',
#	v_port_imps_be		=> '3013',
#	int_vip_cluster		=> 'tbd',
#	stage			=> post,
# }

class abimport ($unity_branch		= '1.0',
		$heap			= '1024',
		$offheap		= '1024',
		$port_snmp		= '4000',
		$snmp_receiver_ip	= '172.16.36.105',
		$l_port_abimport_mo	= '3030',
		$v_port_imps_be		= '3013',
		$int_vip_cluster	= 'tbd' ) {

	include abimport::install, abimport::config, abimport::service

} # End of class abimport
