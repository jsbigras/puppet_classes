# init.pp

class sysstat {

        package { 'sysstat':
                ensure          => present,
                provider        => yum,
        }
}
