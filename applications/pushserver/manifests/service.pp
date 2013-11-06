# Class: pushserver::service
# This module manage the services of the pushserver component on the server.
#

class pushserver::service {

	exec { 'start_pushserver':
		command	=> 'su - ozimps -c \'nmp start pushserver\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check pushserver\' | grep \'is running\'',
		require	=> Class['pushserver::config'],
	}

} # End of class pushserver::service
