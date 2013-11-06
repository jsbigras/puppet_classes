# Class: a3server::install
# This module manage the packages installion of the a3server on the server.
#

class a3server::install {

	package { 'nokia_a3server':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

} # End of class a3server::install
