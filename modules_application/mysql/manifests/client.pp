# client.pp

class mysql::client {

	package { 'MySQL-client':
		ensure		=> present,
		provider	=> yum,
	}	

}
