# Class: cmp::install
# This module manage the packages installion of the cmp on the server.
#

class cmp::install {

	package { 'jre':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['mysql'],
	}

} # End of class cmp::install
