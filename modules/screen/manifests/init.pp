# init.pp

class screen {

        package { 'screen':
                ensure          => present,
                provider        => yum,
        }

	service { 'screen':
		enable =>	true,
		require =>	Package['screen'],
	}

}
