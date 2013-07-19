# Class: basics
# This module manages the basics that shoudl apply to all servers

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
    package { 'git' :
        ensure => 'installed',
    }
    package { 'unzip' :
        ensure => 'installed',
    }
    package { 'tcpdump' :
        ensure => 'installed',
    }
    package { 'telnet' :
        ensure => 'installed',
    }
} # End of class 'basics'
