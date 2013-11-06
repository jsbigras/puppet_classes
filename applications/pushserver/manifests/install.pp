# Class: pushserver::install
# This module manage the packages installion of the pushserver on the server.
#

class pushserver::install {

	package { 'nokia_social_pluginapi':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

	package { 'pushserver_pluginapi':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

	package { 'nmp_pushserver':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_social_pluginapi','pushserver_pluginapi'],
	}

	package { 'nokia_plugin_ews':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_facebook':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_gmail':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_hotmail':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_imap':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_pop3':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_twitter':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

	package { 'nokia_plugin_yahoo':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nmp_pushserver'],
	}

} # End of class pushserver::install
