class ntp::service {
   $ensure = $ntp::start ? {true => running, default => stopped}
 
   service{"ntpd":
      ensure  => $ensure,
      enable  => $ntp::enable,
   }
}
