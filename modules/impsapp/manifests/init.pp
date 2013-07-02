# Class: impsapp
# This module is for the basic config common to IMPS app servers

class impsapp {
    package { 'mysql' :
        ensure => 'installed',
    }
} # End of class 'impsapp'
