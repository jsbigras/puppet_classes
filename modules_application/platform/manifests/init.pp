# Class: platform
# This module install the unity platform and monit on the server.
#
# Parameters:
#
# $port_monit: Listening port for monit on all components.
# $port_monit		= '3000'
#
# $maxfileidle: in Hours (/opt/nokia/nmp/conf/transactionrecords.xml)
# $maxfileidle		= '1'
#
# $maxfilestale: in Hours (/opt/nokia/nmp/conf/transactionrecords.xml)
# $maxfilestale		= '12'
#
# Sample usage:
#
# class { 'platform':
#	port_monit	=> '3000',
#	maxfileidle	=> '1',
#	maxfilestale	=> '12',
#	stage		=> post,
# }

class platform (	$port_monit	= '3000',
			$maxfileidle	= '1',
			$maxfilestale	= '12' ) {

	include platform::install, platform::config

} # End of class platform
