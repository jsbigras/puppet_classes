# Class: pam_d
# This module manages pam.d/login file in Messagin Gateway solution
#
# Parameters:
# No parameters are needed to be passed. The templates is selected based on the OS release 
# and updated based on the architecture
#
# 	<% if architecture == 'x86_64' -%>
# 	session    required     /lib64/security/pam_limits.so
# 	<% else -%>
# 	session    required     /lib/security/pam_limits.so
# 	<% end -%>
#
# Sample usage:
#
# include pam_d

class pam_d_new {

	file { '/etc/pam.d/login':
		owner	=> root,
		group	=> root,
		mode	=> 0644,
		content	=> $lsbdistrelease ? {
				/^5/ => template('pam_d_new/login.RH5.erb'),
				/^4/ => template('pam_d_new/login.RH4.erb'),
		},
	}

} # End of class pam_d_new
