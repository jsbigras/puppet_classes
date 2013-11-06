# Class: mcollective::install
# This module manage the packages installion of the mcollective component on the server.
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

class mcollective_new::install {
	
	package { 'mcollective':
		ensure		=> present,
		provider	=> yum,
	}
	
	package { 'ruby-irb':
		ensure		=> present,
		provider	=> yum,
	}
	
	package { 'ruby-docs':
		ensure		=> present,
		provider	=> yum,
	}
	
} # End of class mcollective_new::install
