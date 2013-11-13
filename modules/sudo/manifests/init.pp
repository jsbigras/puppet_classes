# init.pp

class sudo {

        package { 'sudo':
                ensure          => present,
                provider        => yum,
        }
}
