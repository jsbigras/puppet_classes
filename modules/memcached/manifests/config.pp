class memcached::config {
   $port = $memcached::port,
   $user = $memcached::user,
   $maxconn = $memcached::maxconn,
   $cachesize = $memcached::cachesize,
   $options = $memcached::options

   File{
      owner   => root,
      group   => root,
      mode    => 644,
   }
 
   file{'/etc/sysconfig/memcached':
         content => template('memcached/memcached.erb');
    }
}
