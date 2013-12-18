# Class: mysql
# This module install the Mysql client or the Client and the Server.
#
# Parameters:
#
# $version: MySql version.
# $version         = '5.6.14-1.rhel5'
#
# Sample usage:
#
# class { mysql:
#       version			=> '5.6.14-1.rhel5',
#       stage			=> post,
# }

class mysql (	$version		= '5.6.14-1.rhel5' ) {

	include mysql::client

} # End of class mysql
