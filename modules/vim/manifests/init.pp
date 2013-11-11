# init.pp

class vim {

        package { 'vim-common':
                ensure          => present,
                provider        => yum,
        }

        package { 'vim-minimum':
                ensure          => present,
                provider        => yum,
        }
}
