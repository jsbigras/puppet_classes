# Class: a3server::service
# This module manage the services of the a3server component on the server.
#

class a3server::service {

	exec { 'start_a3server':
		command	=> 'su - ozimps -c \'nmp start a3server\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check a3server\' | grep \'is running\'',
		require	=> Class['a3server::config'],
	}

} # End of class a3server::service
