# Class: kannel::service
# This module manage the services of the kannel component on the server.
#

class kannel::service {

	exec { 'kannel_start':
		command		=> 'su - ozimps -c \'kannel start\'',
		path		=> ['/bin', '/usr/bin', 'home/ozimps/bin'],
		unless		=> 'su - ozimps -c \'kannel summary\' | grep \'Process.*running\'',
		require		=> Class['kannel::config'],
	}

} # End of class kannel::service
