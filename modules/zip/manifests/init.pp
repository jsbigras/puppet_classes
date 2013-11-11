# init.pp

class vim {

        package { 'zip':
                ensure          => present,
                provider        => yum,
        }

        package { 'unzip':
                ensure          => present,
                provider        => yum,
        }
}

