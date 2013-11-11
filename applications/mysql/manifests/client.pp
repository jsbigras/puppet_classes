# client.pp

class mysql::client {

	package { "MySQL-client":
		ensure		=> /${version}/,
		provider	=> yum,
	}	

} # End of class mysql::client:w
