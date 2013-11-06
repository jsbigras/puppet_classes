# init.pp

class network_lo {

        file { '/etc/sysconfig/network-scripts/ifcfg-lo':
                owner		=> root,
                group		=> root,
                mode		=> 0644,
                source		=> 'puppet:///modules/network_lo/ifcfg-lo',
        }

}
