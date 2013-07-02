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
} # End of class 'basics'
