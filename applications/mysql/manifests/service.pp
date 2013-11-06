# service.pp

class mysql::service {

	service { 'mysql':
		enable	=> true,
		ensure	=> running,
		require	=> Class['mysql::server'],
	}

} # End of class mcollective_server_new::service
