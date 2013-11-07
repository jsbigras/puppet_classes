# init.pp

class nfs-utils {

        package { 'nfs-utils':
                ensure          => present,
                provider        => yum,
        }

	service { 'nfs-utils':
		enable =>	true,
		require =>	Package['nfs-utils'],
	}

}
