# Class: limits_conf
# This module manages limit.conf file in Messagin Gateway solution
#
# Parameters:
#
# $nofile: The max number of open files
# $nofile = '650000'
#
# $nproc: The max number of processes
# $nproc = '25000'
#
# $memlock: The max locked-in-memory address space (KB)
# $memlock = 'nd'
#
# $my_role: The role of the server in this environment.
# $my_role = '<server role>'
#
# Sample usage:
#
# class { 'limits_conf':
#       nofile 	=> '650000',
#       nproc 	=> '25000',
#       memlock	=> 'nd',
#       my_role => '<server role>',
# }

class limits_conf_new (	$nofile  = '650000',
			$nproc   = '25000',
			$memlock = 'nd',
                  	$my_role = '<server role>' ) {

	file { '/etc/security/limits.conf':
		owner	=> root,
		group	=> root,
		mode	=> 0644,
		content	=> template('limits_conf_new/limits.conf.erb'),
	}

} # End of class limits_conf_new
