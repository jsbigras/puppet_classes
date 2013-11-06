# Class: li::install
# This module manage the packages installion of the li on the server.
#

class li::install {

	package { 'jre':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['mysql'],
	}

} # End of class li::install
