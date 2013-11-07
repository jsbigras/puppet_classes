# init.pp

class mailx {

        package { 'mailx':
                ensure          => present,
                provider        => yum,
        }

	service { 'mailx':
		enable =>	true,
		require =>	Package['mailx'],
	}

}
