# Class: users
# This module manages users creation in Messagin Gateway solution
#
# Parameters:
#
# $my_role: The role of the server in this environment.
# $my_role = '<server role>'
#
# Sample usage:
#
# class { 'users':
#       my_role => '<server role>',
# }

class users_new {

	include users_new::config

} # End of class users_new
