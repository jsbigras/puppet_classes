class ntp::config {
   $ntpservers = $ntp::ntpservers

   File{
      owner   => root,
      group   => root,
      mode    => 644,
   }
 
   file{'/etc/ntp.conf':
         content => template('ntp/ntp.conf.erb');
    }
}