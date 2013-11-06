class role_general_new {						# New created role
	if $lsbdistcodename != NahantUpdate4 {
		class { set_repos_new: 					# New created module
			yum_server1	=> $g_yum_server1,
			my_role		=> $s_my_role,
			unity_branch	=> $s_unity_branch,
			stage		=> pre, 
		}
	}

	class { facts_new: 						# New created module
		my_env			=> $s_my_env, 
		my_role 		=> $s_my_role, 
		stage 			=> pre, 
	}
	class { users_new:						# New created module
		my_role			=> $s_my_role,
		stage			=> pre,
	}
#	class { scripts_dir: stage 	=> pre }
	class { ad_client_new: 						# New created module
		auth_server1_name 	=> $g_auth_server1_name, 
		auth_server1_ip   	=> $g_auth_server1_ip, 
		auth_server2_name 	=> $g_auth_server2_name, 
		auth_server2_ip   	=> $g_auth_server2_ip, 
		ou 		  	=> $g_ou, 
		cn 		  	=> $s_cn,
	}
	class { ntp_client_new:						# New created module
		ntp_servers		=> $g_ntp_servers,
	}
	class { crond_new:						# New created module
		nagios_cron 		=> $s_nagios_cron,
                my_role                 => $s_my_role,
	}
	include fstab
	class { hosts_file_new:						# New created module
		hosts_file		=> $s_hosts_file,
		auth_server1_name 	=> $g_auth_server1_name, 
		auth_server1_ip   	=> $g_auth_server1_ip, 
		auth_server2_name 	=> $g_auth_server2_name, 
		auth_server2_ip   	=> $g_auth_server2_ip, 
	}
	include issue
	class { mcollective_new:					# New created module
		mc_server       	=> $g_mc_server,
		mc_user         	=> $g_mc_user,
		mc_password     	=> $g_mc_password,
	}
	include network_lo
	class { resolv_conf_new:					# New created module
		dns_servers 		=> $g_dns_servers,
	}
	include services_stopped_new					# New created module
	include sshd
	include su
	class { sysctl_conf_new: 					# New created module
		kernel_shmmax 		=> $s_kernel_shmmax, 
		kernel_shmall 		=> $s_kernel_shmall, 
		vm_nr_hugepages		=> $s_vm_nr_hugepages,
		vm_hugetlb_shm_group    => $s_vm_hugetlb_shm_group,
                my_role                 => $s_my_role,
	}
	class { syslog_conf_new:					# New created module
		syslog_server  		=> $g_syslog_server,
	}
	include sysstat
	class { limits_conf_new: 					# New created module
		nofile 			=> $s_nofile, 
		nproc 			=> $s_nproc, 
		memlock 		=> $s_memlock, 
		my_role                 => $s_my_role,
	}
	class { pam_d_new: }						# New created module
	include dir_colors

	case $manufacturer {
		HP:	{ class { hp_agents_new: 			# New created module
			rwcommunity     => $g_rwcommunity,
			rocommunity     => $g_rocommunity,
			snmp_servers    => $g_snmp_servers,
			trapdestination => $g_trapdestination,
			trapcommunity   => $g_trapcommunity,
			}
		}
		default:{ class { snmpd_new:				# New created module
			rocommunity     => $g_rocommunity,
			snmp_servers    => $g_snmp_servers,
			trapdestination => $g_trapdestination,
			trapcommunity   => $g_trapcommunity,
			}
		}
	}
}

class role_general_without_hostsFiles_new {                             # New created role
	if $lsbdistcodename != NahantUpdate4 {
		class { set_repos_new:                                  # New created module
			yum_server1     => $g_yum_server1,
			stage           => pre,
		}
	}

	class { facts_new:                                              # New created module
		my_env                  => $s_my_env,
		my_role                 => $s_my_role,
		stage                   => pre,
	}
	class { users_new:                                              # New created module
		my_role                 => $s_my_role,
		stage                   => pre,
	}
#	class { scripts_dir: stage      => pre }
	class { ad_client_new:                                          # New created module
		auth_server1_name       => $g_auth_server1_name,
		auth_server1_ip         => $g_auth_server1_ip,
		auth_server2_name       => $g_auth_server2_name,
		auth_server2_ip         => $g_auth_server2_ip,
		ou                      => $g_ou,
		cn                      => $s_cn,
	}
	class { ntp_client_new:                                         # New created module
		ntp_servers             => $g_ntp_servers,
	}
	class { crond_new:						# New created module
		nagios_cron 		=> $s_nagios_cron,
                my_role                 => $s_my_role,
	}
	include fstab
	include issue
	class { mcollective_new:                                        # New created module
		mc_server               => $g_mc_server,
		mc_user                 => $g_mc_user,
		mc_password             => $g_mc_password,
	}
	include network_lo
	class { resolv_conf_new:                                        # New created module
		dns_servers             => $g_dns_servers,
	}
	include services_stopped_new                                    # New created module
	include sshd
	include su
	class { sysctl_conf_new:                                        # New created module
		kernel_shmmax           => $s_kernel_shmmax,
		kernel_shmall           => $s_kernel_shmall,
		vm_nr_hugepages         => $s_vm_nr_hugepages,
		vm_hugetlb_shm_group    => $s_vm_hugetlb_shm_group,
                my_role                 => $s_my_role,
	}
	class { syslog_conf_new:                                        # New created module
		syslog_server           => $g_syslog_server,
	}
	include sysstat
	class { limits_conf_new:                                        # New created module
		nofile                  => $s_nofile,
		nproc                   => $s_nproc,
		memlock                 => $s_memlock,
		my_role                 => $s_my_role,
	}
	class { pam_d_new: }                                            # New created module
	include dir_colors

	case $manufacturer {
		HP:     { class { hp_agents_new:                        # New created module
			rwcommunity     => $g_rwcommunity,
			rocommunity     => $g_rocommunity,
			snmp_servers    => $g_snmp_servers,
			trapdestination => $g_trapdestination,
			trapcommunity   => $g_trapcommunity,
			}
		}
		default:{ class { snmpd_new:                            # New created module
			rocommunity     => $g_rocommunity,
			snmp_servers    => $g_snmp_servers,
			trapdestination => $g_trapdestination,
			trapcommunity   => $g_trapcommunity,
			}
		}
	}
}

class role_download_external {
	class { downloadserver_new:					# New created module
                operations_email        => $g_operations_email,
	}
}

class role_ftp_external {
	include ftpserver
}
