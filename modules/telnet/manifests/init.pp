# init.pp

class telnet {

        package { 'telnet':
                ensure          => present,
                provider        => yum,
        }

	service { 'telnet':
		enable =>	true,
		require =>	Package['telnet'],
	}

}
