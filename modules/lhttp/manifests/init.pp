# Class: lhttp
# This module manages the basics that should apply to all IMPS lhttp servers

class lhttp {
    file { "/etc/init.d/current-lb":
        owner => 'root',
        group => 'root',
        mode  => '0755',
        source  => 'puppet:///modules/lhttp/current-lb',
    }
} # End of class 'lhttp'
