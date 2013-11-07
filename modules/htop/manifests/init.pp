# init.pp

class htop {

        package { 'htop':
                ensure          => present,
                provider        => yum,
        }

	service { 'htop':
		enable =>	true,
		require =>	Package['htop'],
	}

}
