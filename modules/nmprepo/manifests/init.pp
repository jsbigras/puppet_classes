# Class: nmprepo
# This module refines the TM nmp all-in-one repo

class nmprepo {
    yumrepo { "nmp":
        baseurl => "http://tm-repos.synchronica.com/nmp/aio",
        descr => "Myriad NMP yum repo",
        enabled => 1,
        gpgcheck => 0
    }
} # End of class 'nmprepo'
