# init.pp

class dos2unix {

        package { 'dos2unix':
                ensure          => present,
                provider        => yum,
        }

}
