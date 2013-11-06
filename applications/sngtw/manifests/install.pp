# Class: sngtw::install
# This module manage the packages installion of the sngtw on the server.
#

class sngtw::install {

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

	package { 'nokia_sngtw':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_social_pluginapi','pushserver_pluginapi'],
	}

	package { 'nokia_plugin_ews':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_facebook':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_gmail':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_google':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_gtalk':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_hotmail':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_icq':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_imap':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_imps':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_pop3':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_twitter':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_yahoo':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

	package { 'nokia_plugin_yahoo_messenger':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['nokia_sngtw'],
	}

} # End of class sngtw::install
