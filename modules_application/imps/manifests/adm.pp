# Class: imps::adm
# This module install the imps admin component on the server.
#
# Parameters:
#
# $branch: The imps branch number
# $branch = '1.0'
#
# $carrier: Carrier name supported.
# $carrier = 'airtel'
#
# $yum_server1: Yum server
# $yum_server = '172.16.36.101'
#
# $path: The path were we can find the carier directory.
# $path = '/opt/colibria'
#
# $heap: The imps component heap value
# $heap = '128'
#
# Sample usage:
#
# class { 'imps::adm':
#	branch		=> '1.0',
#	carrier		=> 'airtel',
#	yum_server1	=> '172.16.36.101',
#	path		=> '/opt/colibria',
#	heap		=> '128',
#	stage		=> post,
# }


class imps::adm (	$branch			= '1.0',
			$carrier		= 'airtel',
			$yum_server1		= '172.16.36.101',
			$path			= '/opt/colibria',
			$heap			= '128' ) {

# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0755,
	}

# Pre-requisite to RRD tool
	package { "cairo-devel.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "pycairo.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "libxml2.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "libxml2-devel.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "pango-devel.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "libpng-devel.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "freetype-devel.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "libart_lgpl.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "libart_lgpl-devel.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { 'xorg-x11-fonts-Type1':
		ensure		=> present,
		provider	=> yum,
	}
	package { "xinetd.$architecture":
		ensure		=> present,
		provider	=> yum,
	}
	package { "libdbi.$architecture":
		ensure		=> present,
		provider	=> yum,
	}

# Install RRD tool
	package { 'lua':
		ensure		=> present,
		provider	=> yum,
		require		=> Package["cairo-devel.$architecture","pycairo.$architecture","libxml2.$architecture","libxml2-devel.$architecture","pango-devel.$architecture","libpng-devel.$architecture","freetype-devel.$architecture","libart_lgpl.$architecture","libart_lgpl-devel.$architecture","xorg-x11-fonts-Type1","xinetd.$architecture","libdbi.$architecture"]
	}
	package { 'rrdtool':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['lua']
	}
	package { 'perl-rrdtool':
		ensure		=> present,
		provider	=> yum,
		require		=> Package['rrdtool']
	}

	exec { 'add_rrdsrv':
		command		=> 'cp -p /etc/services /etc/services.ORIG;echo -e "rrdsrv\t\t13900/tcp\t\t\t# RRD server" >> /etc/services',
		path		=> ['/bin', '/usr/bin'],
		unless		=> 'ls /etc/services.ORIG',
		require		=> Package['perl-rrdtool'],
		notify		=> Service['xinetd'],
	}

	file { 'rrdsrv':
		ensure		=> present,
		path		=> '/etc/xinetd.d/rrdsrv',
		source		=> 'puppet:///modules/imps/rrdsrv',
		require		=> Exec['add_rrdsrv'],
		notify		=> Service['xinetd'],
	}

	service { 'xinetd':
		enable		=> true,
		ensure		=> running,
	}

# Install Admin tool

	file { "${path}/${carrier}/statistics":
		ensure		=> 'directory',
		require		=> File['rrdsrv'],
	}

	exec { "admin-center-${branch}.tar.gz":
		command		=> "wget http://${yum_server1}/yum/Application/${branch}/imps/admin-center-${branch}-${carrier}.tar.gz",
		path		=> ['/bin', '/usr/bin'],
                cwd             => "${path}/${carrier}/",
		unless		=> "ls ${path}/${carrier}/admin-center-${branch}-${carrier}.tar.gz",
		require		=> File["${path}/${carrier}/statistics"],
	}

	exec { 'untar_admin':
		command         => "tar xzvf admin-center-${branch}-${carrier}.tar.gz \
				&& mv `ls | grep admin-center-${branch} | grep -v 'tar.gz'` admin-center-${branch} \
				&& chown -R root:root admin-center-${branch} \
				&& rm -f log/* \
				&& rm -f admin-center-${branch}/logs/* \
				&& rm -f admin-center-${branch}/*.log \
				&& find admin-center-${branch} -name '.svn' -type d | xargs rm -rf",
		path		=> ['/bin', '/usr/bin'],
                cwd             => "${path}/${carrier}/",
		unless		=> "ls ${path}/${carrier}/admin-center-${branch}",
		require		=> Exec["admin-center-${branch}.tar.gz"],
	}

	file { "${path}/${carrier}/current-adm":
		ensure		=> link,
		target		=> "${path}/${carrier}/admin-center-${branch}",
		require		=> Exec['untar_admin'],
	}

	exec { 'adm_vmoptions.ORIG':
		command		=> "cp -p ${path}/${carrier}/current-adm/common/conf/vmoptions ${path}/${carrier}/current-adm/common/conf/vmoptions.ORIG",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "ls ${path}/${carrier}/current-adm/common/conf/vmoptions.ORIG",
		require         => File["${path}/${carrier}/current-adm"],
	}

	exec { 'adm_vmoptions':
		command		=> "sed -i -e \"s/-Xms.*m/-Xms${heap}m/\" ${path}/${carrier}/current-adm/common/conf/vmoptions \
				&& sed -i -e \"s/-Xmx.*m/-Xmx${heap}m/\" ${path}/${carrier}/current-adm/common/conf/vmoptions",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "grep -i \"Xms${heap}m\" ${path}/${carrier}/current-adm/common/conf/vmoptions \
				&& grep -i \"Xmx${heap}m\" ${path}/${carrier}/current-adm/common/conf/vmoptions",
		require         => Exec['adm_vmoptions.ORIG'],
	}

} # End of class imps::adm
