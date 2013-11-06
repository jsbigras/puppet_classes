# Class: sngtw::service
# This module manage the services of the sngtw component on the server.
#

class sngtw::service {

	exec { 'start_sngtw':
		command	=> 'su - ozimps -c \'nmp start sngtw\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check sngtw\' | grep \'is running\'',
		require	=> Class['sngtw::config'],
	}

} # End of class sngtw::service
