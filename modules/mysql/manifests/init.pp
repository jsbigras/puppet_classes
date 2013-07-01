# Class: mysql
# This module manages basic mysql

class mysql {
    package { 'mysql' :
        ensure => 'installed',
    }
    service { 'mysql':
        enable => true,
    }
} # End of class 'mysql'
