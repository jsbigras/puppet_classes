# init.pp

class vixie-cron {

        package { 'vixie-cron':
                ensure          => present,
                provider        => yum,
        }

	service { 'vixie-cron':
		enable =>	true,
		require =>	Package['vixie-cron'],
	}

}
