# Class: mcollective::service
# This module manage the services of the mcollective component on the server.
#
# Parameters:
#
# $mc_server: mcollective server
# $mc_server = 'suwpuppet01.mt2.suw.hostings.op'
#
# $mc_user: mcollective username
# $mc_user = 'mcollective'
#
# $mc_password: mcollective password
# $mc_password = 'marionette'
#
# Sample usage:
#
# class { 'mcollective':
#       mc_server	=> 'suwpuppet01.mt2.suw.hostings.op',
#       mc_user		=> 'mcollective',
#       mc_password	=> 'marionette',
# }

class mcollective_new::service {

	service { 'mcollective':
		enable		=> true,
		ensure		=> running,
		require		=> Class['mcollective_new::install'],
	}

} # End of class mcollective_new::service
