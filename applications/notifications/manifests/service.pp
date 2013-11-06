# Class: notifications::service
# This module manage the services of the notifications component on the server.
#

class notifications::service {

	exec { 'start_notifications':
		command	=> 'su - ozimps -c \'nmp start notifications\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check notifications\' | grep \'is running\'',
		require	=> Class['notifications::config'],
	}

} # End of class notifications::service
