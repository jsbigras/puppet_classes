# init.pp

class vim {

        package { 'vim-common':
                ensure          => present,
                provider        => yum,
        }

	service { 'vim-common':
		enable =>	true,
		require =>	Package['vim-common'],
	}

        package { 'vim-minimum':
                ensure          => present,
                provider        => yum,
        }

	service { 'vim-minimum':
		enable =>	true,
		require =>	Package['vim-minimum'],
	}
}
