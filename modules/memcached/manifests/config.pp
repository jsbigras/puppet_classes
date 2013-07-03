class memcached::config {
   File{
      owner   => root,
      group   => root,
      mode    => 644,
   }
 
   file{'/etc/sysconfig/memcached':
         content => template('memcached/memcached.erb');
    }
}
