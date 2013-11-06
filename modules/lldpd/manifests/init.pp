# init.pp

class lldpd {

	package { 'lldpd':
		ensure =>	present,
		provider =>	yum,
	}

	service { 'lldpd':
		enable =>	false,
		ensure =>	stopped,
		hasstatus =>	false,
		status =>	'ps -C lldpd',
		require	=>	Package['lldpd'],
	}

}
