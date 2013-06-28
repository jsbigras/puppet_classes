# Class: memcached
# This module manages Memcached

class memcached {
    package { 'memcached' :
        ensure => '1.4.15',
    }
} # End of class 'memcached'
