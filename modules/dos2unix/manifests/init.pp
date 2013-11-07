# init.pp

class dos2unix {

        package { 'dos2unix':
                ensure          => present,
                provider        => yum,
        }

	service { 'dos2unix':
		enable =>	true,
		require =>	Package['dos2unix'],
	}

}
