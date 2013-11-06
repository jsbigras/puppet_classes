# init.pp

class sysstat {

        package { 'sysstat':
                ensure          => present,
                provider        => yum,
        }

	service { 'sysstat':
		enable =>	true,
		require =>	Package['sysstat'],
	}

}
