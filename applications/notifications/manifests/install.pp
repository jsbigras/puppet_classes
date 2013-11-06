# Class: notifications::install
# This module manage the packages installion of the notifications on the server.
#

class notifications::install {

	package { 'ns_pluginapi':
		ensure		=> present,
		provider	=> yum,
		require		=> Class['platform::config'],
	}

	package { 'notifications':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['ns_pluginapi'],
	}

	package { 'ns_plugin_gcm':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['notifications'],
	}

	package { 'ns_plugin_http':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['notifications'],
	}

	package { 'ns_plugin_kannel':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['notifications'],
	}

	package { 'ns_plugin_lhttp':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['notifications'],
	}

	package { 'ns_plugin_tcp':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['notifications'],
	}

} # End of class notifications::install
