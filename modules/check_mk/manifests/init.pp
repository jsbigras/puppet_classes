# init.pp

class check_mk {

        file { '/etc/xinetd.d/check_mk':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                source		=> 'puppet:///modules/check_mk/check_mk',
        }
        file { '/usr/bin/check_mk_agent':
                owner		=> root,
                group		=> root,
                mode		=> 0755,
                source		=> 'puppet:///modules/check_mk/check_mk_agent',
        }
        exec { '/sbin/service xinetd reload':
                refreshonly     => true,
                subscribe       => File['/etc/xinetd.d/check_mk'],
        }


}
