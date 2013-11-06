# Class: mcollective server::install
# This module manage the installation of the mcollective component on the server.
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

class mcollective_server_new::install {

	package { ['mcollective-client', 'activemq', 'activemq-info-provider', 'tanukiwrapper', 'rubygems', 'rubygem-stomp', 'jpackage-utils', 'java-1.6.0-openjdk', 'ruby-rdoc']:
		ensure		=>	present,
	}

} # End of class mcollective_server_new::install
