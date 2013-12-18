# Class: users
# This module manages users creation in Messagin Gateway solution
#
# Parameters:
#
# Sample usage:
#
# class { 'users':
# }

class AWS_users {

	include AWS_users::install, AWS_users::config, AWS_users::service

} # End of class AWS_users
