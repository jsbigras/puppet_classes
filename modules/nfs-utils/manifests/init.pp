# init.pp

class nfs-utils {

        package { 'nfs-utils':
                ensure          => present,
                provider        => yum,
        }
}
