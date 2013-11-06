# Class: sysctl_conf
# This module manages sysctl.conf file in Messagin Gateway solution
#
# Parameters:
#
# $kernel_shmmax: Controls the maximum shared segment size, in bytes
# $kernel_shmmax = '68719476736'
#
# $kernel_shmall: Controls the maximum number of shared memory segments, in pages
# kernel_shmall = '4294967296'
#
# $vm_nr_hugepages: Size of huge pages (database only)
# vm_nr_hugepages = 'nd'
#
# $vm_hugetlb_shm_group: Size of huge pages (database only)
# vm_hugetlb_shm_group = 'nd'
#
# $my_role: The role of the server in this environment.
# $my_role = '<server role>'
#
# Sample usage:
#
# class { 'sysctl_conf':
#       kernel_shmmax		=> '68719476736',
#       kernel_shmall		=> '4294967296',
#       vm_nr_hugepages		=> 'nd',
#       vm_hugetlb_shm_group	=> 'nd',
#       my_role 		=> '<server role>',
# }

class sysctl_conf_new ( $kernel_shmmax   = '68719476736',
                        $kernel_shmall   = '4294967296',
                        $vm_nr_hugepages = 'nd',
                        $vm_hugetlb_shm_group = 'nd',
                  	$my_role 	 = '<server role>' ) {

	file { '/etc/sysctl.conf':
		owner	=> root,
		group	=> root,
		mode	=> 0644,
		content	=> $lsbdistrelease ? {
				/^5/ => template('sysctl_conf_new/sysctl.conf.RH5.erb'),
				/^4/ => template('sysctl_conf_new/sysctl.conf.RH4.erb'),
		}
	}

	exec { '/sbin/sysctl -p':
		refreshonly	=> true,
		subscribe	=> File['/etc/sysctl.conf'],
	}

} # End of class sysctl_conf_new
