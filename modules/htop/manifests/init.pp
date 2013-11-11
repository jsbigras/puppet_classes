# init.pp

class htop {

        package { 'htop':
                ensure          => present,
                provider        => yum,
        }
}
