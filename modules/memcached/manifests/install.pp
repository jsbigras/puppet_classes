class memcached::install {
   package{'memcached':
      ensure => $memcached::version
   }
}
