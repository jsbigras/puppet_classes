# Class: users
# This module manages users creation in Messagin Gateway solution
#
# Parameters:
#
# Sample usage:
#
# class { 'users':
# }

class aws_users {

	include aws_users::install, aws_users::config, aws_users::service

} # End of class aws_users
