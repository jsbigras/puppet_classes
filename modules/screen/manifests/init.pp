# init.pp

class screen {

        package { 'screen':
                ensure          => present,
                provider        => yum,
        }
}
