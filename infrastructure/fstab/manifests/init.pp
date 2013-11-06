# init.pp

class fstab {

	mount { '/tmp':
#		ensure		=> present,
		options		=> 'defaults,noatime,nodev,nosuid',
#		device		=> '/dev/vg_root/lv_tmp',
#		fstype		=> ext3,
		dump            => '1',
                pass            => '2',
	}

	mount { '/':
#		ensure		=> present,
                options		=> 'defaults,noatime',
#                device		=> '/dev/vg_root/lv_root',
#                fstype		=> ext3,
		dump		=> '1',
		pass		=> '1',
        }

	mount { '/var':
#		ensure		=> present,
                options		=> 'defaults,noatime,nodev',
#                device		=> '/dev/vg_root/lv_var',
#                fstype		=> ext3,
		dump		=> '1',
		pass		=> '2',
        }

}
