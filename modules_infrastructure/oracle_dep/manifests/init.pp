# init.pp

class oracle_dep {

        package { ['libaio.i386', 'libaio.x86_64']:
                ensure          => present,
                provider        => yum,
        }

        package { ['glibc-devel.i386', 'glibc-devel.x86_64']:
                ensure          => present,
                provider        => yum,
        }

        package { 'libgcc.i386':
                ensure          => present,
                provider        => yum,
        }

	package { ['gcc', 'gcc-c++']:
                ensure          => present,
                provider        => yum,
        }

        package { 'compat-db':
                ensure          => present,
                provider        => yum,
        }

        package { 'gnome-libs':
                ensure          => present,
                provider        => yum,
        }

        package { 'openmotif21':
                ensure          => present,
                provider        => yum,
        }

	package { ['vte', 'pygtk2']:
		ensure		=> present,
		provider	=> yum,
	}

	package { ['vnc-server', 'xorg-x11-xauth', 'xorg-x11-twm', 'xterm', 'xorg-x11']:
		ensure		=> present,
		provider	=> yum,
	}

}
