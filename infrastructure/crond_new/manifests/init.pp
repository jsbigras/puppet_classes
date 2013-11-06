# Class: crond
# This module manages users allow to use cronjob.
#
# Parameters:
#
# $nagios_cron: Nagios user allow to use cronjob.
# $nagios_cron = 'nd'
#
# $my_role: The role of the server in this environment.
# $my_role = '<server role>'
#
# Sample usage:
#
# class { 'crond':
#       nagios_cron  => 'nd',
#       my_role => '<server role>',
# }

class crond_new ( $nagios_cron = 'nd',
                  $my_role = '<server role>' ) {

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner	=> root,
		group	=> root,
		mode	=> 0400,
	}

	file { '/etc/cron.allow':
                content => template('crond_new/cron.allow.erb'),
	}

        file { '/etc/at.allow':
		source	=> 'puppet:///modules/crond_new/at.allow'
	}

	file { '/etc/cron.deny':
		ensure	=> absent,
	}

	file { '/etc/at.deny':
		ensure	=> absent,
	}

	file { ['/etc/cron.weekly/00-makewhatis.cron', '/etc/cron.weekly/makewhatis.cron']:
		ensure	=> absent,
	}

	file { ['/etc/cron.daily/00-makewhatis.cron', '/etc/cron.daily/makewhatis.cron']:
		ensure	=> absent,
	}

	file { ['/etc/cron.daily/slocate.cron', '/etc/cron.daily/mlocate.cron']:
		ensure	=> absent,
	}

} # End of class crond_new
