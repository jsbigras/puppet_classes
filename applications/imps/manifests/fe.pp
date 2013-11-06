# Class: imps::fe
# This module install the imps fe component on the server.
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
# class { 'imps::fe':
#	branch		=> '1.0',
#	carrier		=> 'airtel',
#       yum_server1     => '172.16.36.101',
#	path		=> '/opt/colibria',
#	heap		=> '512',
#	stage		=> post,
# }


class imps::fe (	$branch		= '1.0',
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

# Install Front-End
        exec { "frontend-${branch}.tar.gz":
                command         => "wget http://${yum_server1}/yum/Application/${branch}/imps/frontend-${branch}-${carrier}.tar.gz",
                path            => ['/bin', '/usr/bin'],
                cwd             => "${path}/${carrier}/",
                unless          => "ls ${path}/${carrier}/frontend-${branch}-${carrier}.tar.gz",
        }

        exec { 'untar_fe':
		command         => "tar xzvf frontend-${branch}-${carrier}.tar.gz \
				&& mv `ls | grep frontend-${branch} | grep -v 'tar.gz'` frontend-${branch} \
				&& chown -R root:root frontend-${branch} \
				&& rm -f log/* \
				&& rm -f frontend-${branch}/logs/* \
				&& rm -f frontend-${branch}/*.log \
				&& find frontend-${branch} -name '.svn' -type d | xargs rm -rf",
                path            => ['/bin', '/usr/bin'],
                cwd             => "${path}/${carrier}/",
                unless          => "ls ${path}/${carrier}/frontend-${branch}",
                require         => Exec["frontend-${branch}.tar.gz"],
        }

	file { "${path}/${carrier}/current-fe":
		ensure		=> link,
		target		=> "${path}/${carrier}/frontend-${branch}",
		require		=> Exec['untar_fe'],
	}

	exec { 'fe_vmoptions.ORIG':
		command		=> "cp -p ${path}/${carrier}/current-fe/common/conf/vmoptions ${path}/${carrier}/current-fe/common/conf/vmoptions.ORIG",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "ls ${path}/${carrier}/current-fe/common/conf/vmoptions.ORIG",
		require         => File["${path}/${carrier}/current-fe"],
	}

	exec { 'fe_vmoptions':
		command		=> "sed -i -e \"s/-Xms.*m/-Xms${heap}m/\" ${path}/${carrier}/current-fe/common/conf/vmoptions \
				&& sed -i -e \"s/-Xmx.*m/-Xmx${heap}m/\" ${path}/${carrier}/current-fe/common/conf/vmoptions",
		path		=> ['/bin', '/usr/bin'],
		unless		=> "grep -i \"Xms${heap}m\" ${path}/${carrier}/current-fe/common/conf/vmoptions \
				&& grep -i \"Xmx${heap}m\" ${path}/${carrier}/current-fe/common/conf/vmoptions",
		require         => Exec['fe_vmoptions.ORIG'],
	}

        exec { 'fe_jolokia':
                command         => "echo \"-javaagent:/opt/jolokia/jolokia-jvm-1.1.1-agent.jar=port=17704,host=`hostname -i`,policyLocation=file:///opt/jolokia/jolokia-access.xml\" >> ${path}/${carrier}/current-fe/common/conf/vmoptions",
                path            => ['/bin', '/usr/bin'],
                unless          => "grep -i \"jolokia\" ${path}/${carrier}/current-fe/common/conf/vmoptions",
                require         => Exec['fe_vmoptions.ORIG'],
        }

} # End of class imps::fe
