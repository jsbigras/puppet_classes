# Class: nmptaskmanager::service
# This module manage the services of the nmptaskmanager component on the server.
#

class nmptaskmanager::service {

	exec { 'start_nmptaskmanager':
		command	=> 'su - ozimps -c \'nmp start nmptaskmanager\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check nmptaskmanager\' | grep \'is running\'',
		require	=> Class['nmptaskmanager::config'],
	}

} # End of class nmptaskmanager::service
