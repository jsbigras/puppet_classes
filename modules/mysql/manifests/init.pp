# Class: mysql
# This module manages basic mysql

class mysql {
    package { 'mysql' :
        ensure => 'installed',
    }
} # End of class 'mysql'
