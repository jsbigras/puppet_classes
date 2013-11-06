# init.pp

class perl_crypt {

        package { 'perl-Crypt-Blowfish':
                ensure		=> present,
		provider	=> yum,
        }

        package { 'perl-Crypt-CBC':
                ensure		=> present,
		provider	=> yum,
        }

}
