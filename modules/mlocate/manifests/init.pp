# init.pp

class mlocate {

        package { 'mlocate':
                ensure          => present,
                provider        => yum,
        }

	service { 'mlocate':
		enable =>	true,
		require =>	Package['mlocate'],
	}

}
