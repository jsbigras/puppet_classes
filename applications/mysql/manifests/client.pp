# client.pp

class mysql::client {

	package { "MySQL-client":
		present		=> "${version}",
		provider	=> yum,
	}	

} # End of class mysql::client:w
