# Class: espws::install
# This module manage the packages installion of the espws on the server.
#

class espws::install {

	package { 'espws':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['mysql','platform::config'],
	}

} # End of class espws::install
