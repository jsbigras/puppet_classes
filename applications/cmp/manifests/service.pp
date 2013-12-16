# Class: cmp::service
# This module manage the services of the cmp component on the server.
#

class cmp::service {

#	exec { 'start_cmp':
#		command	=> 'su - ozimps -c \'sh /opt/tomcat/bin/startup.sh\'',
#		path	=> ['/home/ozimps/bin','/bin'],
#		unless	=> 'su - ozimps -c \'nmp check myriadstore\' | grep \'is running\'',
#		require	=> Class['cmp::config'],
#	}

} # End of class cmp::service
