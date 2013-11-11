# init.pp

class vixie-cron {

        package { 'vixie-cron':
                ensure          => present,
                provider        => yum,
        }
}
