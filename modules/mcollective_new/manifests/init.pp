# Class: mcollective
# This module install the mcollective component on the server.
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

class mcollective_new ( $mc_server	= 'suwpuppet01.mt2.suw.hostings.op',
			$mc_user	= 'mcollective',
			$mc_password	= 'marionette' ) {
	
	include mcollective_new::install, mcollective_new::config, mcollective_new::service

} # End of class mcollective_new
