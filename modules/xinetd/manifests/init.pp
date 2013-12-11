# init.pp

class xinetd {

        package { 'xinetd':
                ensure          => present,
                provider        => yum,
        }
        service { 'xinetd':
                ensure          => running,
                enable          => true,
                require         => Exec['xinetd-reload'],
        }

        exec { 'xinetd-reload':
                command         => '/etc/init.d/xinetd reload',
                refreshonly     => true,
                require         => Package['xinetd'],
        }
}
