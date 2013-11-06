# init.pp

class issue {

        file { '/etc/issue':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                source		=> 'puppet:///modules/issue/issue',
        }

}
