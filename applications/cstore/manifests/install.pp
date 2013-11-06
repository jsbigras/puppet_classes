# Class: cstore::install
# This module manage the packages installion of the cstore on the server.
#

class cstore::install {

	package { 'myriadstore':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['mysql','platform::config'],
	}

} # End of class cstore::install
