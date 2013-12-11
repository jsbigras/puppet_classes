# init.pp

class xinetd {

        package { 'xinetd':
                ensure          => present,
                provider        => yum,
        }
}
