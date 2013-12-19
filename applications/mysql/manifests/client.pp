# client.pp

class mysql::client inherits mysql {

	package { 'MySQL-client':
		ensure		=> $version,
		provider	=> yum,
	}	

} # End of class mysql::client
