# init.pp

class selinux {

        file { '/etc/selinux/config':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                source		=> 'puppet:///modules/selinux/config',
        }

}
