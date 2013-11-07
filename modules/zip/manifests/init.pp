# init.pp

class vim {

        package { 'zip':
                ensure          => present,
                provider        => yum,
        }

        service { 'zip':
                enable =>       true,
                require =>      Package['zip'],
        }

        package { 'unzip':
                ensure          => present,
                provider        => yum,
        }

        service { 'unzip':
                enable =>       true,
                require =>      Package['unzip'],
        }
}

