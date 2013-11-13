# init.pp

class unzip {

        package { 'unzip':
                ensure          => present,
                provider        => yum,
        }
}
