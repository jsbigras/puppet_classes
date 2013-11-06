# init.pp

class su {

	file { '/etc/pam.d/su':
		owner		=> root,
		group		=> root,
		mode		=> 0644,
		content		=> template('su/pam.su.erb'),
	}

}	
