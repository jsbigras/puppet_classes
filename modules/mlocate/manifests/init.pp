# init.pp

class mlocate {

        package { 'mlocate':
                ensure          => present,
                provider        => yum,
        }
}
