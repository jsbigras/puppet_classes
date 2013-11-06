# Class: hp_agents
# This module install the hp agents
#
# Parameters:
#
# $nofile: The max number of open files
# $nofile = '650000'
#
# $nproc: The max number of processes
# $nproc = '25000'
#
# $memlock: The max locked-in-memory address space (KB)
# $memlock = 'nd'
#
# Sample usage:
#
# class { 'hp_agents':
#       rwcommunity     => '0zsnmp0',
#       rocommunity     => '0zsnmp0',
#       snmp_servers    => [ '172.16.36.131', '172.16.36.132', '172.16.36.105' ],
#       trapdestination => '172.16.36.105',
#       trapcommunity   => '0zsnmp0',
# }

class hp_agents_new ( $rwcommunity     = '0zsnmp0',
                      $rocommunity     = '0zsnmp0',
                      $snmp_servers    = [ '172.16.36.131', '172.16.36.132', '172.16.36.105' ],
                      $trapdestination = '172.16.36.105',
                      $trapcommunity   = '0zsnmp0' ) {

	package { ['cpqacuxe', 'hpacucli', 'hpaducli', 'hpdiags', 'hp-health', 'hp-ilo', 'hponcfg', 'hpsmh', 'hp-smh-templates', 'hp-snmp-agents']:
		ensure		=> present,
		provider	=> yum,
	}	

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0600,
	}

	file { '/etc/snmp/snmpd.conf':
		require		=> Package['cpqacuxe', 'hpacucli', 'hpaducli', 'hpdiags', 'hp-health', 'hp-ilo', 'hponcfg', 'hpsmh', 'hp-smh-templates', 'hp-snmp-agents'],
 		content		=> template('hp_agents_new/hp-snmpd.conf.erb'),
	}
	
	file { '/etc/hp-snmp-agents.conf':
		require		=> File['/etc/snmp/snmpd.conf'],
		content		=> template('hp_agents_new/hp-snmp-agents.conf.erb'),
	}	

	service { ['hpsmhd', 'hp-health', 'hp-snmp-agents', 'hp-ilo', 'hp-asrd']:
		ensure		=> running,
		subscribe	=> File['/etc/hp-snmp-agents.conf'],
	}

} # End of class hp_agents_new
