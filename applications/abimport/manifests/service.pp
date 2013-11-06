# Class: abimport::service
# This module manage the services of the abimport component on the server.
#

class abimport::service {

	exec { 'start_cus':
		command	=> 'su - ozimps -c \'nmp start cus\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check cus\' | grep \'is running\'',
		require	=> Class['abimport::config'],
	}

} # End of class abimport::service
