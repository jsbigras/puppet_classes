# Class: imps
# This module manages the basics that should apply to all IMPS servers

class imps {
    package { 'monit' :
        ensure => '5.4-1.el5.rf',
    }
    file { [ '/opt/colibria/', '/opt/colibria/telcel' ] :
        ensure => 'directory',
        owner => 'root',
        group => 'root',
        mode => '0755',
    }
} # End of class 'imps'
