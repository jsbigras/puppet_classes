# Class: mcollective server
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
# class { 'mcollective_server':
#       mc_server       => 'suwpuppet01.mt2.suw.hostings.op',
#       mc_user         => 'mcollective',
#       mc_password     => 'marionette',
# }

class mcollective_server_new ( 	$mc_server      = 'suwpuppet01.mt2.suw.hostings.op',
				$mc_user        = 'mcollective',
				$mc_password    = 'marionette' ) {

#	require mcollective_new
	include mcollective_server_new::install, mcollective_server_new::config, mcollective_server_new::service

} # End of class mcollective_server_new
