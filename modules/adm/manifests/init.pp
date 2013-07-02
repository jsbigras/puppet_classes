# Class: adm
# This module manages the basics that should apply to all IMPS adm servers

class adm {
    file { "/etc/init.d/current-adm":
        owner => 'root',
        group => 'root',
        mode  => '0755',
        source  => 'puppet:///modules/adm/current-adm',
    }
} # End of class 'adm'
