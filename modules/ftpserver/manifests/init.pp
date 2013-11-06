# init.pp

class ftpserver {

        package { ['vsftpd']:
                ensure          => present,
                provider        => yum,
        }

        file { '/etc/vsftpd/vsftpd.conf':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                content		=> template('ftpserver/vsftpd_conf.erb'),
		require		=> Package['vsftpd'],
        }

	service { 'vsftpd':
                ensure          => running,
                enable          => true,
		require		=> Exec['vsftpd-reload'],
        }

	exec { 'vsftpd-reload':
		command 	=> '/etc/init.d/vsftpd reload',
		refreshonly 	=> true,
		require 	=> Package['vsftpd'],
		subscribe	=> File['/etc/vsftpd/vsftpd.conf'],
	}

}
