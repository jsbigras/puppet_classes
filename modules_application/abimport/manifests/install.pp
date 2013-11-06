# Class: abimport::install
# This module manage the packages installion of the abimport on the server.
#

class abimport::install {

	package { 'cus':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

} # End of class abimport::install
