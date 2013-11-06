# Class: nmptaskmanager::install
# This module manage the packages installion of the nmptaskmanager on the server.
#

class nmptaskmanager::install {

	package { 'nokia_nmp_taskmanager':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['mysql','platform::config'],
	}

} # End of class nmptaskmanager::install
