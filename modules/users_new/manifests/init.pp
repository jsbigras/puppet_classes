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

class users_new ( $my_role = '<server role>' ) {

	include users_new::install, users_new::config, users_new::service

} # End of class users_new
