# Class: imps::lb
# This module install the imps lb component on the server.
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
# $heap = '512'
#
# Sample usage:
#
# class { 'imps::lb':
#	branch		=> '1.0',
#	carrier		=> 'airtel',
#       yum_server1     => '172.16.36.101',
#	path		=> '/opt/colibria',
#	heap		=> '512',
#	stage		=> post,
# }


class imps::lb (	$branch		= '1.0',
			$carrier	= 'airtel',
                        $yum_server1    = '172.16.36.101',
			$path		= '/opt/colibria',
			$heap		= '512' ) {

# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0755,
	}

# Install Application
        exec { "loadbalancer-${branch}.tar.gz":
                command         => "wget http://${yum_server1}/yum/Application/${branch}/imps/loadbalancer-${branch}-${carrier}.tar.gz",
                path            => ['/bin', '/usr/bin'],
                cwd             => "${path}/${carrier}/",
                unless          => "ls ${path}/${carrier}/loadbalancer-${branch}-${carrier}.tar.gz",
        }

        exec { 'untar_lb':
		command         => "tar xzvf loadbalancer-${branch}-${carrier}.tar.gz \
				&& mv `ls | grep loadbalancer-${branch} | grep -v 'tar.gz'` loadbalancer-${branch} \
				&& chown -R root:root loadbalancer-${branch} \
				&& rm -f log/* \
				&& rm -f loadbalancer-${branch}/logs/* \
				&& rm -f loadbalancer-${branch}/*.log \
				&& find loadbalancer-${branch} -name '.svn' -type d | xargs rm -rf",
                path            => ['/bin', '/usr/bin'],
                cwd             => "${path}/${carrier}/",
                unless          => "ls ${path}/${carrier}/loadbalancer-${branch}",
                require         => Exec["loadbalancer-${branch}.tar.gz"],
        }

	file { "${path}/${carrier}/current-lb":
		ensure		=> link,
		target		=> "${path}/${carrier}/loadbalancer-${branch}",
		require		=> Exec['untar_lb'],
	}

	exec { 'lb_vmoptions.ORIG':
		command		=> "cp -p ${path}/${carrier}/current-lb/common/conf/vmoptions ${path}/${carrier}/current-lb/common/conf/vmoptions.ORIG",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "ls ${path}/${carrier}/current-lb/common/conf/vmoptions.ORIG",
		require         => File["${path}/${carrier}/current-lb"],
	}

	exec { 'lb_vmoptions':
		command		=> "sed -i -e \"s/-Xms.*m/-Xms${heap}m/\" ${path}/${carrier}/current-lb/common/conf/vmoptions \
				&& sed -i -e \"s/-Xmx.*m/-Xmx${heap}m/\" ${path}/${carrier}/current-lb/common/conf/vmoptions",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "grep -i \"Xms${heap}m\" ${path}/${carrier}/current-lb/common/conf/vmoptions \
				&& grep -i \"Xmx${heap}m\" ${path}/${carrier}/current-lb/common/conf/vmoptions",
		require         => Exec['lb_vmoptions.ORIG'],
	}

	exec { 'lb_jolokia':
		command		=> "echo \"-javaagent:/opt/jolokia/jolokia-jvm-1.1.1-agent.jar=port=17705,host=`hostname -i`,policyLocation=file:///opt/jolokia/jolokia-access.xml\" >> ${path}/${carrier}/current-lb/common/conf/vmoptions",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "grep -i \"jolokia\" ${path}/${carrier}/current-lb/common/conf/vmoptions",
		require         => Exec['lb_vmoptions.ORIG'],
	}

} # End of class imps::lb
