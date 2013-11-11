# Class: set_repos
# This module manages set_repos in Messagin Gateway solution
#
# Parameters:
#
# $yum_server1: Yum servers
# $yum_server1 = '172.16.36.101'
#
# $unity_branch: The unity branch number
# $unity_branch = '1.0'
#
# $my_role: Server role, usually the component name
# $my_role = 'tbd'
#
# Sample usage:
#
# class { 'set_repos':
#       yum_server1 => '172.16.36.101',
#       unity_branch => '1.0',
#       my_role => 'tbd',
# }

class set_repos_new ( 	$yum_server1  = 'tm-repos.synchronica.com' ) {

	file {  ['/etc/yum.repos.d/CentOS-Base.repo', '/etc/yum.repos.d/CentOS-Debuginfo.repo', '/etc/yum.repos.d/kickstart.repo',
		'/etc/yum.repos.d/rhel4.8.repo', '/etc/yum.repos.d/CentOS-Media.repo', '/etc/yum.repos.d/CentOS-Vault.repo']:
		ensure		=> absent,
	}

        yumrepo { 'Base':
                baseurl         => "http://${yum_server1}/centos/5.9/os/${architecture}",
                descr           => 'Base Packages',
                enabled         => 1,
                gpgcheck        => 0,
        }

	yumrepo { 'Custom':
		baseurl		=> "http://${yum_server1}/centos/5.9/custom/${architecture}",
		descr		=> 'Custom Packages',
		enabled		=> 1,
		gpgcheck	=> 0,
	}

	yumrepo { 'Errata':
		baseurl		=> "http://${yum_server1}/centos/5.9/errata/${architecture}",
		descr		=> 'Errata Packages',
		enabled		=> 1,
		gpgcheck	=> 0,
	}

} # End of class set_repos_new
