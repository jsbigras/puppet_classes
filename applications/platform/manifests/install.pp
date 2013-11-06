# Class: platform::install
# This module manage the packages installion of the platform and monit on the server.
#

class platform::install {

	package { 'jdk':
		ensure		=> present,
		provider	=> yum,
	}

	package { 'monit':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['jdk'],
	}

	package { 'nokia_monit_cfg':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['monit'],
	}

	package { 'nokia_nmp':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_monit_cfg'],
	}

} # End of class platform::install
