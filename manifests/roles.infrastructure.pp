class role_general {

	include bc
	include bind-utils
#	include dir_colors		Will see.
	include dos2unix
#	include fstab			We cannot used this class at AWS.
	include git
##	include htop			Not pertinent even at Termark.
#	include issue			To be updated.
#	include limits_conf_new		We used the aws_limit_conf instead.
	include aws_limits_conf
	include mailx
	include mlocate
#	include network_lo		We cannot used this class at AWS.
	include nfs-utils
#	include oz_app_requirements	Not pertinent even at Termark.
##	include perl_crypt		We cannot find it at AWS.
##	include portmap
#	include resolv_conf_new		We cannot used this class at AWS.
#	include scripts_dir		Not pertinent even at Termark.
#	include selinux			This was necessary only for the DB servers, not needed for AWS.
#	include sendmail_new		Not for now.
	include services_stopped_new
#	include set_repos_new		We used the aws_set_repos instead.
	class { aws_set_repos:
		yum_server1	=> $g_yum_server1,
		my_role		=> $s_my_role,
		stage		=> pre,
	}
	include sudo
#	include sysctl_conf_new		Not pertinent for AWS.
#	include syslog_conf_new		Not for now.
	include sysstat
	include tcpdump
	include telnet
	include unzip
#	include users_new		We used the aws_users instead.
	include aws_users
	include vim
##	include vixie-cron		We cannot find it at AWS.
#	include zip			Get an error inside.
}
