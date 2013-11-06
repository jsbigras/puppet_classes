# init.pp

class oz_app_requirements {

        file { [ '/var/log/oz', '/opt/oz', '/var/oz/', '/var/oz/repository', '/opt/java', '/opt/sun' ]:
		owner		=> 500,
		group		=> 500,
		mode		=> 0755,
		ensure		=> directory,
		require		=> User['ozimps'],
        }

}
