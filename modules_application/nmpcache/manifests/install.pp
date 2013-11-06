# Class: nmpcache::install
# This module manage the packages installion of the nmpcache on the server.
#

class nmpcache::install {

	package { 'cache_server':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

} # End of class nmpcache::install
