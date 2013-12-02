# init.pp

class bind-utils {

        package { 'bind-utils':
                ensure          => present,
                provider        => yum,
        }
}
