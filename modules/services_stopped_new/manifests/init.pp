# init.pp

class services_stopped_new {

	service { 'autofs':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'bluetooth':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'cups':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'isdn':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'hidd':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'nfslock':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'pcmcia':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'pcscd':
		ensure		=> stopped,
		enable		=> false,
	}
	
	service { 'rhnsd':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'rpcgssd':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'rpcidmapd':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'smartd':
		ensure		=> stopped,
		enable		=> false,
	}

	service { 'yum-updatesd':
		ensure		=> stopped,
		enable		=> false,
	}	

	service { 'iptables':
		ensure		=> stopped,
		enable		=> false,
	}	

}
