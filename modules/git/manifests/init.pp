# init.pp

class git {

        package { 'git':
                ensure          => present,
                provider        => yum,
        }
}
