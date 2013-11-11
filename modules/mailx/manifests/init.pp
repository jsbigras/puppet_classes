# init.pp

class mailx {

        package { 'mailx':
                ensure          => present,
                provider        => yum,
        }
}
