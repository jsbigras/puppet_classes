# Class: mysql
# This module manages basic mysql

class mysql {
    package { 'mysql' :
        ensure => 'installed',
    }
    package { 'mysql-server' :
        ensure => 'installed',
    }
    service { 'mysqld':
        enable => true,
    }
} # End of class 'mysql'
