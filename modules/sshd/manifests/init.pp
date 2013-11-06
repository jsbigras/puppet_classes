# init.pp

class sshd {

	file { '/etc/ssh/sshd_config':
                owner		=> root,
                group		=> root,
                mode		=> 0600,
		content		=> template('sshd/sshd_config.erb'),
	}

	service { 'sshd':
		ensure		=> running,
		subscribe	=> File['/etc/ssh/sshd_config'],
		require		=> File['/etc/ssh/sshd_config'],
	}

}
