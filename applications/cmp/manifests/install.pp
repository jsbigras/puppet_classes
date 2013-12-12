# Class: cmp::install
# This module manage the packages installion of the cmp on the server.
#

class cmp::install {

	package { 'jre':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['mysql'],
	}

	package { 'apache-tomcat':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['jre'],
	}

	package { 'cmp':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['apache-tomcat'],
	}

} # End of class cmp::install
