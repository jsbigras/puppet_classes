# Class: nmptranscoder::install
# This module manage the packages installion of the nmptranscoder on the server.
#

class nmptranscoder::install {

	package { 'nokia_nmp_transcoder':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

} # End of class nmptranscoder::install
