# init.pp

class vim {

        package { 'vim-common':
                ensure          => present,
                provider        => yum,
        }

        package { 'vim-minimal':
                ensure          => present,
                provider        => yum,
        }
}
