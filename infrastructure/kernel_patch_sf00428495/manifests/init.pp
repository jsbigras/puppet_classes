# init.pp

class kernel_patch_sf00428495 {

$kernel_version = 'vmlinuz-2.6.9-89.0.20.EL.sf00428495smp'
$set_boot_image = '/opt/infrastructure/scripts/set_boot_image'

        package { ['kernel-smp-2.6.9-89.0.20.EL.sf00428495', 'kernel-smp-devel-2.6.9-89.0.20.EL.sf00428495', 'augeas']:
                ensure          => present,
                provider        => yum,
        }

        file { '/opt/infrastructure/scripts/set_boot_image':
                owner           => root,
                group           => root,
                mode            => 0700,
                source          => 'puppet:///modules/kernel_patch_sf00428495/set_boot_image',
                require         => Package['kernel-smp-2.6.9-89.0.20.EL.sf00428495'],
        }

	exec { 'set_boot_image':
		command		=> "${set_boot_image} ${kernel_version}",
                refreshonly     => true,
                subscribe       => Package['kernel-smp-2.6.9-89.0.20.EL.sf00428495'],
        }

}
