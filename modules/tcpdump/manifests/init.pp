# init.pp

class tcpdump {

        package { 'tcpdump':
                ensure          => present,
                provider        => yum,
        }
}
