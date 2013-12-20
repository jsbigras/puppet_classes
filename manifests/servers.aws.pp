node /^demo-v-abimport-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'cus'			# We need to add it, used in module facts/manifests/init.pp:18
						# We need to add it, used in module users/manifests/init.pp:37/186
	$s_unity_branch = '2.3'			# Unity branch

	# include "stage => post" roles
	# -----------------------------------
	include role_abimport

	# include "stage => pre/main" <-- These must be added under the "stage => post"
	# -----------------------------------
	include role_general
}

node /^demo-v-kan-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'kannel'			# We need to add it, used in module facts/manifests/init.pp:18
						# We need to add it, used in module users/manifests/init.pp:37/186

	# include "stage => post" roles
	# -----------------------------------
	include role_kan

	# include "stage => pre/main" <-- These must be added under the "stage => post"
	# -----------------------------------
	include role_general
}

node /^demo-v-aaa-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'a3server'                 # We need to add it, used in module facts/manifests/init.pp:18
                                                # We need to add it, used in module users/manifests/init.pp:37/186
	$s_unity_branch = '2.3'			# Unity branch

        # include "stage => post" roles
        # -----------------------------------
        include role_aaa

        # include "stage => pre/main" <-- These must be added under the "stage => post"
        # -----------------------------------
        include role_general
}

node /^demo-v-cache-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'nmpcache'			# We need to add it, used in module facts/manifests/init.pp:18
						# We need to add it, used in module users/manifests/init.pp:37/186
	$s_unity_branch = '2.3'			# Unity branch

	# include "stage => post" roles
	# -----------------------------------
	include role_cache

	# include "stage => pre/main" <-- These must be added under the "stage => post"
	# -----------------------------------
	include role_general
}

node /^demo-v-imps-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'imps'			# We need to add it, used in module facts/manifests/init.pp:18
						# We need to add it, used in module users/manifests/init.pp:37/186
	$s_carrier = 'demo'			# Carrier name supported.
	$s_imps_path = '/opt/myriad'		# The path were we can find the carier directory.

	# include "stage => post" roles
	# -----------------------------------
	include role_imps_base
	include role_imps_adm
#	include role_imps_fe
	include role_imps_app
#	include role_imps_memcache
	include role_imps_lb

	# include "stage => pre/main" <-- These must be added under the "stage => post"
	# -----------------------------------
	include role_general
}

node /^demo-v-ns-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'notifications'		# We need to add it, used in module facts/manifests/init.pp:18
						# We need to add it, used in module users/manifests/init.pp:37/186
	$s_unity_branch = '2.3'			# Unity branch

	# include "stage => post" roles
	# -----------------------------------
	include role_ns

	# include "stage => pre/main" <-- These must be added under the "stage => post"
	# -----------------------------------
	include role_general
}

node /^demo-v-cstore-\d+/ inherits global_specific_aws {
	$s_hosts_file = 'hosts.demo.erb'	# Host file template filename
	$s_my_role = 'myriadstore'		# We need to add it, used in module facts/manifests/init.pp:18
						# We need to add it, used in module users/manifests/init.pp:37/186
	$s_unity_branch = '2.3'			# Unity branch

	# include "stage => post" roles
	# -----------------------------------
	include role_cstore

	# include "stage => pre/main" <-- These must be added under the "stage => post"
	# -----------------------------------
	include role_general
}

node 'ip-10-110-221-71' inherits global_specific_aws {
        $s_hosts_file = 'hosts.demo.erb'        # Host file template filename
        $s_my_role = 'cmp'                      # We need to add it, used in module facts/manifests/init.pp:18
                                                # We need to add it, used in module users/manifests/init.pp:37/186
	$s_unity_branch = '2.3'			# Unity branch

        # include "stage => post" roles
        # -----------------------------------
        include role_cmp

        # include "stage => pre/main" <-- These must be added under the "stage => post"
        # -----------------------------------
        include role_general
}
