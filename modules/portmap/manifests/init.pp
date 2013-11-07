# init.pp

class portmap {

        package { ['portmap']:
                ensure          => present,
                provider        => yum,
        }

	service { 'portmap':
                ensure          => running,
                enable          => true,
		require		=> Exec['portmap-reload'],
        }

	exec { 'portmap-reload':
		command 	=> '/etc/init.d/portmap reload',
		refreshonly 	=> true,
		require 	=> Package['portmap'],
	}

}
