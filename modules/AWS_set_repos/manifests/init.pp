# Class: set_repos
# This module manages set_repos in Messagin Gateway solution
#
# Parameters:
#
# $yum_server1: Yum servers
# $yum_server1 = '172.16.36.101'
#
# $my_role: Server role, usually the component name
# $my_role = 'tbd'
#
# Sample usage:
#
# class { 'set_repos':
#       yum_server1 => '172.16.36.101',
#       my_role => 'tbd',
# }

class AWS_set_repos ( 	$yum_server1  = '172.16.36.101',
                        $my_role = 'tbd' ) {

	if $my_role != 'tbd' {
		yumrepo { 'Application':
			baseurl		=> "http://${yum_server1}/yum/Application/${my_role}",
			descr		=> 'Application Packages',
			enabled		=> 1,
			gpgcheck	=> 0,
		}
	}

} # End of class AWS_set_repos
