# Class: basics
# This module manages the basics that should apply to all servers
#

class basics {
    package { 'zip' :
        ensure => 'installed',
    }
    package { 'mlocate' :
        ensure => 'installed',
    }
    package { 'screen' :
        ensure => 'installed',
    }
    package { 'unzip' :
        ensure => 'installed',
    }
    package { 'git' :
        ensure => 'installed',
    }
    package { 'tcpdump' :
        ensure => 'installed',
    }
    package { 'telnet' :
        ensure => 'installed',
    }
    package { 'vim-common' :
        ensure => 'installed',
    }
    package { 'vim-minimal' :
        ensure => 'installed',
    }
} # End of class 'basics'
