# Class: ad_client
# This module manages limit.conf file in Messagin Gateway solution
#
# Parameters:
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
# $ou: Active Directory OU
# $ou = 'mt2'
#
# $cn: Server type
# $cn = 'APP_CONN'
#
# Sample usage:
#
# class { 'ad_client':
#       auth_server1_name => 'ad14.hosting.ops',
#       auth_server1_ip   => '192.168.130.101',
#       auth_server2_name => 'ad16.hosting.ops',
#       auth_server2_ip   => '192.168.130.102',
#	ou		  => 'mt2',
#       cn                => 'APP_CONN',
# }

class ad_client_new ( $auth_server1_name = 'ad14.hosting.ops',
		      $auth_server1_ip	 = '192.168.130.101',
		      $auth_server2_name = 'ad16.hosting.ops',
		      $auth_server2_ip	 = '192.168.130.102',
		      $ou		 = 'mt2',
		      $cn 		 = 'APP_CONN' ) {

        # "File" Type is a code compresiion technique which defined default value to be used within this scope.
        File {
                owner    => root,
                group    => root,
		mode	 => 0644,
        }

	package { 'sudo':
		ensure	 => latest,
		provider => yum,
	}

        file { '/etc/ldap.conf':
		content	 => $lsbdistrelease ? {
				/^5/ => template('ad_client_new/ldap.conf.RH5.erb'),
				/^4/ => template('ad_client_new/ldap.conf.RH4.erb'),
		},
        }

	file { '/etc/nsswitch.conf':
		source	 => 'puppet:///modules/ad_client_new/nsswitch.conf',
	}

	file { '/etc/pam.d/system-auth':
		path	 => $lsbdistrelease ? {	
				/^5/ =>	'/etc/pam.d/system-auth-ac',
				/^4/ =>	'/etc/pam.d/system-auth',
		},
		source	 => $lsbdistrelease ? {
				/^5/ =>	'puppet:///modules/ad_client_new/system-auth-ac.RH5',
				/^4/ =>	'puppet:///modules/ad_client_new/system-auth.RH4',
		},
	}

	if $lsbmajdistrelease == 5 {
		file { '/etc/ldap.secret':
			ensure	=> present,
			mode	=> 0400,
			source	=> 'puppet:///modules/ad_client_new/ldap.secret',
		}
	}

        cron { 'faillog_clean':
		command	 => '/usr/bin/faillog -r > /dev/null',
		minute	 => '*/5',
        }

	host { 'ad_server1':
		name	 => $auth_server1_name,
		ip	 => $auth_server1_ip,
	}

	host { 'ad_server2':
		name 	 => $auth_server2_name,
		ip 	 => $auth_server2_ip,
	}

} # End of class ad_client_new
