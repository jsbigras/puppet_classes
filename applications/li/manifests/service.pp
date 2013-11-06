# Class: li::service
# This module manage the services of the li component on the server.
#

class li::service {

#	exec { 'start_myriadstore':
#		command	=> 'su - ozimps -c \'nmp start myriadstore\'',
#		path	=> ['/home/ozimps/bin','/bin'],
#		unless	=> 'su - ozimps -c \'nmp check myriadstore\' | grep \'is running\'',
#		require	=> Class['li::config'],
#	}

} # End of class li::service
