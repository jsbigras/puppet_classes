# Class: imps
# This module creates the basic directory for imps component on the server.
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
# Sample usage:
#
# class { imps:
#       branch		=> '1.0',
#	carrier		=> 'airtel',
#       yum_server1     => '172.16.36.101',
#	path		=> '/opt/colibria',
#	stage		=> post,
# }

class imps (	$branch		= '1.0',
		$carrier        = 'airtel',
		$yum_server1    = '172.16.36.101',
		$path		= '/opt/colibria' ) {

	# "File" Type is a code compression technique which defined default value to be used within this scope.
	File {
		owner		=> root,
		group		=> root,
		mode		=> 0755,
	}

	file { '/opt/jolokia':
		ensure		=> directory,
	}

	file { "${path}":
		ensure		=> directory,
	}

	file { "${path}/${carrier}":
		ensure		=> directory,
	}

# Install Jlokia
        exec { 'jolokia-jvm-agent.zip':
                command         => "wget http://${yum_server1}/yum/Application/${branch}/imps/jolokia-jvm-agent.zip",
                path            => ['/bin', '/usr/bin'],
                cwd             => '/opt/jolokia/',
                unless          => 'ls /opt/jolokia/jolokia-jvm-agent.zip',
                require         => File["${path}"],
        }

        exec { 'untar_jolokia':
                command         => 'unzip /opt/jolokia/jolokia-jvm-agent.zip',
                path            => ['/bin', '/usr/bin'],
                cwd             => '/opt/jolokia/',
                unless          => [ 'ls /opt/jolokia/jolokia-access.xml','ls /opt/jolokia/jolokia-jvm-1.1.1-agent.jar'],
                require         => Exec['jolokia-jvm-agent.zip'],
        }

} # End of class imps
