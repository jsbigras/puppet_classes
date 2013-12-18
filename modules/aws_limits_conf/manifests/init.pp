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

class aws_limits_conf (	$nofile  = '650000',
			$nproc   = '25000',
			$memlock = 'nd',
			$my_role = '<server role>' ) {

# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

        exec { 'limit.conf.ORIG':
                command		=> 'cp -p /etc/security/limits.conf /etc/security/limits.conf.ORIG',
                path		=> ['/bin', '/usr/bin'],
                unless		=> 'ls /etc/security/limits.conf.ORIG',
        }

	file { '/etc/security/limits.conf':
		content		=> template('aws_limits_conf/limits.conf.erb'),
		require		=> Exec['limit.conf.ORIG'],
	}

} # End of class aws_limits_conf
