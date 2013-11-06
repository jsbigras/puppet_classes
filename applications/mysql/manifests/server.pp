# server.pp

class mysql::server {

	# We include the client rpm to the MySQL server too.
	include mysql::client, mysql::config, mysql::service

	package { 'MySQL-devel':
		ensure		=> present,
		provider	=> yum,
	}	

	package { 'MySQL-server':
		ensure		=> present,
		provider	=> yum,
	}	

	package { 'MySQL-shared':
		ensure		=> present,
		provider	=> yum,
	}	

	package { 'MySQL-shared-compat':
		ensure		=> present,
		provider	=> yum,
	}	

}
