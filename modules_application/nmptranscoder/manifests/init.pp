# Class: nmptranscoder
# This module install the unity nmptranscoder and monit on the server.
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
# $v_port_xcoder: The component port listening
# $v_port_xcoder = '<port>'
#
# Sample usage:
#
# class { nmptranscoder:
#	unity_branch		=> '1.0',
#	heap			=> '1024',
#	offheap			=> '1024',
#	port_snmp		=> '4000',
#	snmp_receiver_ip	=> '172.16.36.105',
#	v_port_xcoder		=> '3002',
#	stage			=> post,
# }

class nmptranscoder (	$unity_branch	  = '1.0',
			$heap		  = '1024',
			$offheap	  = '1024',
			$port_snmp	  = '4000',
			$snmp_receiver_ip = '172.16.36.105',
			$v_port_xcoder	  = '3002' ) {

	include nmptranscoder::install, nmptranscoder::config, nmptranscoder::service

} # End of class nmptranscoder
