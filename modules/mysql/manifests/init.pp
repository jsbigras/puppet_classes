# Class: mysql
# This module manages basic mysql

# Please note that it does not do the following:
#  * Start the service (only 'ckconfig on')
#  * Secure the installation (use /usr/bin/mysql_secure_installation or equiv)

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
