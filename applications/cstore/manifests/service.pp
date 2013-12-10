# Class: cstore::service
# This module manage the services of the cstore component on the server.
#

class cstore::service {

#	exec { 'start_myriadstore':
#		command	=> 'su - ozimps -c \'nmp start myriadstore\'',
#		path	=> ['/home/ozimps/bin','/bin'],
#		unless	=> 'su - ozimps -c \'nmp check myriadstore\' | grep \'is running\'',
#		require	=> Class['cstore::config'],
#	}

} # End of class cstore::service
