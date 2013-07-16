class ntp::install {
   package{'ntp':
      ensure => $ntp::version
   }
}
