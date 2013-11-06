# Class: facts
# This module creates a file in the srver to state the role of the server and the environment.
#
# Parameters:
#
# $my_env: The environment which the server is part of.
# $my_env = 'production-<env>'
#
# $my_role: The role of the server in this environment.
# $my_role = '<server role>'
#
# Sample usage:
#
# class { 'facts':
#       my_env	=> 'production-<env>',
#       my_role	=> '<server role>',
# }

class facts_new ( $my_env  = 'production-<env>',
		  $my_role = '<server role>' ) {

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0644,
	}

	file { '/etc/facts':
		ensure		=> directory,
	}

	file { '/etc/facts/role.txt':
		ensure		=> present,
		content		=> template('facts_new/role.txt.erb'),
	}

} # End of class facts_new
