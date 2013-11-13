# init.pp

class bc {

        package { 'bc':
                ensure          => present,
                provider        => yum,
        }
}
