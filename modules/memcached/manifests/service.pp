class memcached::service {
   $ensure = $memcached::start ? {true => running, default => stopped}
 
   service{"memcached":
      ensure  => $ensure,
      enable  => $memcached::enable,
   }
}
