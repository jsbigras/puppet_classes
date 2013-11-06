# init.pp

class scripts_dir {

	# "File" Type is a code compresiion technique which defined default value to be used within this scope.
	File {
                owner           => root,
                group           => root,
                mode            => 0700,
	}

        file { '/opt/infrastructure':
                ensure          => 'directory',
        }

        file { '/opt/infrastructure/scripts':
		ensure		=> 'directory',
        }

}
