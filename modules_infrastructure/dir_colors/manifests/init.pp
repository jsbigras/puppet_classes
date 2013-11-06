# init.pp

class dir_colors {

        file { '/etc/DIR_COLORS.xterm':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                source		=> 'puppet:///modules/dir_colors/DIR_COLORS.xterm',
        }

}
