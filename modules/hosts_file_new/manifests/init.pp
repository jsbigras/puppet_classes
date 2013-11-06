# Class: hosts_file
# This module manages limit.conf file in Messagin Gateway solution
#
# Parameters:
#
# $hosts_file: Host file template filename
# $hosts_file = 'nd'
#
# $auth_server1_name: Active Directory server 1 name
# $auth_server1_name = 'ad14.hosting.ops'
#
# $auth_server2_name: Active Directory server 2 name
# $auth_server2_name = 'ad16.hosting.ops'
#
# $auth_server1_ip: Active Directory server 1 IP
# $auth_server1_ip = '192.168.130.101'
#
# $auth_server2_ip: Active Directory server 2 IP
# $auth_server2_ip = '192.168.130.102'
#
# Sample usage:
#
# class { 'hosts_file':
#       hosts_file  => 'nd',
#       auth_server1_name => 'ad14.hosting.ops',
#       auth_server1_ip   => '192.168.130.101',
#       auth_server2_name => 'ad16.hosting.ops',
#       auth_server2_ip   => '192.168.130.102',
# }

class hosts_file_new ( $hosts_file = 'nd',
		       $auth_server1_name = 'ad14.hosting.ops',
                       $auth_server1_ip   = '192.168.130.101',
                       $auth_server2_name = 'ad16.hosting.ops',
                       $auth_server2_ip   = '192.168.130.102' ) {

	file { '/etc/hosts':
		owner	=> root,
		group	=> root,
		mode	=> 0644,
		content => template("hosts_file_new/${hosts_file}"),
	}

} # End of class hosts_file_new
