# Class: webredirect
# This module upload the webredirect files needed for twitter and facebook.
#
# Parameters:
#
# Sample usage:
#
# include webredirect
#
class webredirect {

	package { ['perl-URI']:
		ensure		=> present,
		provider	=> yum,
		require		=> Class['httpd'],
	}

	file { '/var/www/cgi-bin/webredirect.zip':
		owner		=> root,
		group		=> root,
		mode		=> 0755,
		source		=> 'puppet:///modules/webredirect/webredirect.zip',
		require		=> Class['httpd'],
	}

	exec { 'PREP-webredirect':
		command		=> 'unzip -d /var/www/cgi-bin/ /var/www/cgi-bin/webredirect.zip;dos2unix /var/www/cgi-bin/sngtw*;chmod 755 /var/www/cgi-bin/sngtw*',
		path		=> ['/usr/bin', '/bin'],
		unless		=> 'ls /var/www/cgi-bin/sngtw*',
		require		=> File['/var/www/cgi-bin/webredirect.zip'],
	}

} # End of class webredirect
