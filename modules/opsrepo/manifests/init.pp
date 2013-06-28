# Class: opsrepo
# This module refines the TM Ops repo

class opsrepo {
    yumrepo { "ops":
        baseurl => "http://tm-repos.synchronica.com/ops",
        descr => "Myriad Ops yum repo",
        enabled => 1,
        gpgcheck => 0
    }
} # End of class 'opsrepo'
