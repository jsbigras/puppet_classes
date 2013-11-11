# init.pp

class telnet {

        package { 'telnet':
                ensure          => present,
                provider        => yum,
        }
}
