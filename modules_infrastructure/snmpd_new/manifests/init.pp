# Class: snmpd
# This module configures snmp in Messagin Gateway solution
#
# Parameters:
#
# $rocommunity: SNMP read-only community
# $rocommunity = '0zsnmp0'
#
# $snmp_servers: SNMP servers
# $snmp_servers = [ '172.16.36.131', '172.16.36.132', '172.16.36.105' ]
#
# $trapdestination: Trap destination
# $trapdestination = '172.16.36.105'
#
# $trapcommunity: Trap community
# $trapcommunity = '0zsnmp0'
#
# Sample usage:
#
# class { 'snmpd':
#       rocommunity	=> '0zsnmp0',
#       snmp_servers	=> [ '172.16.36.131', '172.16.36.132', '172.16.36.105' ],
#       trapdestination	=> '172.16.36.105',
#       trapcommunity	=> '0zsnmp0',
# }

class snmpd_new ( $rocommunity	   = '0zsnmp0',
                  $snmp_servers	   = [ '172.16.36.131', '172.16.36.132', '172.16.36.105' ],
                  $trapdestination = '172.16.36.105',
                  $trapcommunity   = '0zsnmp0' ) {

	package { 'net-snmp':
		ensure		=> present,
		provider	=> yum,
	}	

	package { 'net-snmp-utils':
		ensure		=> present,
		provider	=> yum,
		require         => Package['net-snmp'],
	}	

	file { '/etc/snmp/snmpd.conf':
		owner		=> root,
		group		=> root,
		mode		=> 0600,
		content		=> template('snmpd_new/snmpd.conf.erb'),
		require		=> Package['net-snmp'],
	}

	service { 'snmpd':
		ensure		=> running,
		enable		=> true,
		subscribe	=> File['/etc/snmp/snmpd.conf'],
		require		=> File['/etc/snmp/snmpd.conf'],
	}

} # End of snmpd_new
