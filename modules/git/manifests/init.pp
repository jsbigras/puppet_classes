# init.pp

class git {

        package { 'git':
                ensure          => present,
                provider        => yum,
        }

	service { 'git':
		enable =>	true,
		require =>	Package['git'],
	}

}
