# Class: kannel::install
# This module manage the packages installion of the kannel on the server.
#

class kannel::install {

	package { 'monit':
		ensure		=> present,
		provider	=> yum,
	}

	package { 'nokia_monit_cfg':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['monit'],
	}

	package { 'kannel':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_monit_cfg'], 
	}

} # End of class kannel::install
