# Class: nmptranscoder::service
# This module manage the services of the nmptranscoder component on the server.
#

class nmptranscoder::service {

	exec { 'start_nmptranscoder':
		command		=> 'su - ozimps -c \'nmp start nmptranscoder\'',
		path		=> ['/home/ozimps/bin','/bin'],
		unless		=> 'su - ozimps -c \'nmp check nmptranscoder\' | grep \'is running\'',
		require		=> Class['nmptranscoder::config'],
	}

} # End of class nmptranscoder::service
