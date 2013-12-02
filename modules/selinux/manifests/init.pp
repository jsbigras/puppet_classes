# init.pp
#
# NOTE: This manifest will always for selinux into permissive mode
#	regardless of its configuration. You will need to change
#	the manifest's exec to setenforce 1 to change this.
#	- Douglas 12.02.13

class selinux {

        file { '/etc/selinux/config':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                source		=> 'puppet:///modules/selinux/config',
        }
        exec { '/usr/sbin/setenforce 0':
                refreshonly     => true,
                subscribe       => File['/etc/selinux/config'],
        }

}
