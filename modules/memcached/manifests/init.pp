# Class: memcached
# This module manages Memcached

class memcached {
    package { 'memcached' :
        ensure => '1.4.15-2.el5.remi',
    }
} # End of class 'memcached'
