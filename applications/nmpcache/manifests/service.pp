# Class: nmpcache::service
# This module manage the services of the nmpcache component on the server.
#

class nmpcache::service {

	exec { 'start_nmpcache':
		command	=> 'su - ozimps -c \'nmp start nmpcache\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check nmpcache\' | grep \'is running\'',
		require	=> Class['nmpcache::config'],
	}

} # End of class nmpcache::service
