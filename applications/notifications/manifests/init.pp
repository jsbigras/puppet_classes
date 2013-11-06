# Class: notifications
# This module install the unity notifications and monit on the server.
#
# Parameters:
#
# $unity_branch: The unity branch number
# $unity_branch		= '1.0'
#
# $heap: The unity component heap value
# $heap			= '1024'
#
# $offheap: The unity component offheap value
# $offheap		= '1024'
#
# $port_snmp: The unity component SNMP listening port
# $port_snmp = '4000'
#
# $snmp_receiver_ip: The IP where we send the trap
# $snmp_receiver_ip = '<nagios server ip>'
#
# $l_port_cache: The port the cache server is listening to.
# $l_port_cache = '3001'
#
# $cache_primary: IP address of the primary cache server.
# $cache_primary = 'tbd'
#
# $cache_secondary: IP address of the secondary cache server.
# $cache_secondary = 'tbd'
#
# $cacheid_desc: Components which benefit from the cacheId.
# $cacheid_desc = []
#
# $cacheid_name: cacheId name
# $cacheid_name = []
#
# $cacheid_maxinmem: maxElementsInMemoryForCluster 
# $cacheid_maxinmem = []
#
# $cacheid_verenabled: versioningEnabled
# $cacheid_verenabled = []
#
# $cacheid_hddpersist: hddPersistent off|synchronized|batched
# $cacheid_hddpersist = []
#
# $tokensmemmaxsize: This is the value for the token local cache on the notifications server.
# $tokensmemmaxsize = '30000'
#
# $includeFromShortcode: Include or not shortcode in the SMS request.
# $includeFromShortcode = 'false'
#
# $shortcode: Carrier shortcode.
# $shortcode = '12345'
#
# $l_port_ns: Listening port for tcp-cir traffic.
# $l_port_ns_tcpcir = '3717'
#
# $l_port_ns_lhttp: Listening port for long http traffic.
# $l_port_ns_lhttp = '3011'
#
# $l_port_ns_loop: Listening port for notifications loopback.
# $l_port_ns_loop = '3107'
#
# $l_port_ns_http: Listening port for notifications sent from other components.
# $l_port_ns_http = '3007'
#
# $int_vip_common: Alias used to reach the common virtual IP.
# $int_vip_common = 'tbd'
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
#
# $v_port_mu_ns: Port associated to MU on the LB.
# $v_port_mu_ns = '3015'
#
# $v_port_em2sms: Port associated to EM2SMS on the LB.
# $v_port_em2sms = '3027'
#
# $v_port_kannel_ns: Port associated to Kannel on the LB.
# $v_port_kannel_ns = '3004'
#
# $v_port_aaa_admin: Port associated to AAA admin on the LB.
# $v_port_aaa_admin = '3023'
#
# $gcm_apikey: GCM application key.
# $gcm_apikey = 'tbd'
#
# $gcm_delaywhileidle: GCM iddle flag.
# $gcm_delaywhileidle = 'false'
#
# $descNamePerNC: OperatorName --> "Description name associated to the network code".
# $descNamePerNC = [],
#
# $networkCode: Network code.
# $networkCode = [],
#
# $operatorName: The name of the operator to be configured.
# $operatorName = [], 
#
# $kannel_username: Kannel username.
# $kannel_username = [],
#
# $kannel_password: Kannel password.
# $kannel_password = [],
#
# Sample usage:
#
# class { notifications:
#	unity_branch			=> '1.0',
#	heap				=> '1024',
#	offheap				=> '1024',
#	port_snmp			=> '4000',
#	snmp_receiver_ip		=> '172.16.36.105',
#	l_port_cache			=> '3001',
#	cache_primary			=> 'tbd',
#	cache_secondary			=> 'tbd',
#	cacheid_desc			=> [],
#	cacheid_name			=> [],
#	cacheid_maxinmem		=> [],
#	cacheid_verenabled		=> [],
#	cacheid_hddpersist		=> [],
#	tokensmemmaxsize		=> '30000',
#	includeFromShortcode		=> 'false',
#	shortcode			=> '12345',
#	l_port_ns_tcpcir		=> '3717',
#	l_port_ns_lhttp			=> '3011',
#	l_port_ns_loop			=> '3107',
#	l_port_ns_http			=> '3007',
#	int_vip_common			=> 'tbd',
#	int_vip_cluster			=> 'tbd',
#	v_port_mu_ns			=> '3015',
#	v_port_em2sms			=> '3027',
#	v_port_kannel_ns		=> '3004',
#	v_port_aaa_admin		=> '3023',
#	gcm_apikey			=> 'tbd',
#	gcm_delaywhileidle		=> 'false',
#	descNamePerNC			=> [],
#	networkCode			=> [],
#	operatorNam			=> [],
#	kannel_username			=> [],
#	kannel_password			=> [],
#	stage	=> post,
# }

class notifications (	$unity_branch			= '1.0',
			$heap				= '1024',
			$offheap			= '1024',
			$port_snmp			= '4000',
			$snmp_receiver_ip		= '172.16.36.105',
			$l_port_cache			= '3001',
			$cache_primary			= 'tbd',
			$cache_secondary		= 'tbd',
			$cacheid_desc			= [],
			$cacheid_name			= [],
			$cacheid_maxinmem		= [],
			$cacheid_verenabled		= [],
			$cacheid_hddpersist		= [],
			$tokensmemmaxsize		= '30000',
			$includeFromShortcode		= 'false',
			$shortcode			= '12345',
 			$l_port_ns_tcpcir		= '3717',
			$l_port_ns_lhttp		= '3011',
			$l_port_ns_loop			= '3107',
			$l_port_ns_http			= '3007',
			$int_vip_common			= 'tbd',
			$int_vip_cluster		= 'tbd',
			$v_port_mu_ns			= '3015',
			$v_port_em2sms			= '3027',
			$v_port_kannel_ns		= '3004',
			$v_port_aaa_admin		= '3023',
			$gcm_apikey			= 'tbd',
			$gcm_delaywhileidle		= 'false',
			$descNamePerNC			= [],
			$networkCode			= [],
			$operatorName			= [],
			$kannel_username		= [],
			$kannel_password		= [] ) {

	include notifications::install, notifications::config, notifications::service

} # End of class notifications
