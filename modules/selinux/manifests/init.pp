# Class: selinux
# This module manages selinux using the selinux modules from:
#  https://forge.puppetlabs.com/spiette/selinux
# Installed with:
#  puppet module install spiette/selinux

include selinux

class { 'selinux' :
    mode => 'permissive'
} # End of class 'selinux'
