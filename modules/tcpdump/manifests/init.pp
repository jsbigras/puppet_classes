# init.pp

class tcpdump {

        package { 'tcpdump':
                ensure          => present,
                provider        => yum,
        }

	service { 'tcpdump':
		enable =>	true,
		require =>	Package['tcpdump'],
	}

}
