# Class: sngtw
# This module install the unity sngtw and monit on the server.
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
# $l_port_ug_oauth: Listening port for UG OAUTH traffic.
# $l_port_ug_oauth = '3005'
#
# $l_port_ug_admin: Listening port for long http traffic.
# $l_port_ug_admin = '3004'
#
# $l_port_ug_tauth: Listening port for notifications loopback.
# $l_port_ug_tauth = '3006'
#
# $int_vip_common: Alias used to reach the common virtual IP.
# $int_vip_common = 'tbd'
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
#
# $v_port_aaa_admin: Port associated to AAA admin on the LB.
# $v_port_aaa_admin = '3023'
#
# $v_port_ns_http: Port associated to Notification HTTP on the LB.
# $v_port_ns_http = '3023'
#
# $v_port_espws: Port associated to ESPWS on the LB.
# $v_port_espws = '3023'
#
# $v_port_smtp: Port associated to Fallback SMTP on the LB.
# $v_port_smtp = '3023'
#
# $v_port_xcoder: Port associated to XCODER on the LB.
# $v_port_xcoder = '3023'
#
# $v_port_tm: Port associated to TM on the LB.
# $v_port_tm = '3023'
#
# $yahoodirectoauthsharedsecret: https://developer.apps.yahoo.com/projects/ <-- login to your yahoo credential and create the "Consumer Secret"
# $yahoodirectoauthsharedsecret = 'tbd',
#
# $yahoopwtokensharedsecret: Information we received encrypted, tag as pwtoken.url.mobile0XX (shivshan@yahoo-inc.com or cprithvi@yahoo-inc.com)
# $yahoopwtokensharedsecret = 'tbd',
#
# $yahoosubscriptionsharedsecret: Information we received encrypted, tag as mobile.notification.mobile0XX (shivshan@yahoo-inc.com or cprithvi@yahoo-inc.com)
# $yahoosubscriptionsharedsecret = 'tbd',
#
# $yahoonotificationsharedsecret: Information we received encrypted, tag as mobile.notification.mobile0XX.url (shivshan@yahoo-inc.com or cprithvi@yahoo-inc.com)
# $yahoonotificationsharedsecret = 'tbd',
#
# $yahooconsumerkey: https://developer.apps.yahoo.com/projects/ <-- login to your yahoo credential and create the "Consumer Key"
# $yahooconsumerkey = 'tbd',
#
# $yahoopartnerid: Information we received encrypted, tag as mobile0XX
# $yahoopartnerid = 'tbd',
#
# $yahoosubscribeuri: Nothing specific
# $yahoosubscribeuri = 'tbd',
#
# $yahoo_imapurinongenericoverride: Information we received by Yahoo. (shivshan@yahoo-inc.com or cprithvi@yahoo-inc.com)
# $yahoo_imapurinongenericoverride = 'tbd',
#
# $yahoo_smtpurinongenericoverride: Information we received by Yahoo. (shivshan@yahoo-inc.com or cprithvi@yahoo-inc.com)
# $yahoo_smtpurinongenericoverride = 'tbd'
#
# $yahooMessengerSharedSecret: Yahoo Messenger Shared Secret.
# $yahooMessengerSharedSecret = '839e898ac0feece28689ed29602a1baf3b293f5c'
#
# $yahooMessengerConsumerKey: Yahoo Messenger Consumer Key.
# $yahooMessengerConsumerKey = 'dj0yJmk9M29ZTTdUOU5HUlRiJmQ9WVdrOVUwMVZOMHRrTlRBbWNHbzlPVEF4T1RZMU5qWXkmcz1jb25zdW1lcnNlY3JldCZ4PTc1'
#
# Sample usage:
#
# class { sngtw:
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
#	l_port_ug_oauth			=> '3005',
#	l_port_ug_admin			=> '3004',
#	l_port_ug_tauth			=> '3006',
#	int_vip_common			=> 'tbd',
#	int_vip_cluster			=> 'tbd',
#	v_port_aaa_admin		=> '3023',
#	v_port_ns_http			=> '3007',
#	v_port_espws			=> '3001',
#	v_port_smtp			=> '25',
#	v_port_xcoder			=> '3002',
#	v_port_tm			=> '3026',
#	yahoodirectoauthsharedsecret    => 'tbd',
#	yahoopwtokensharedsecret        => 'tbd',
#	yahoosubscriptionsharedsecret   => 'tbd',
#	yahoonotificationsharedsecret   => 'tbd',
#	yahooconsumerkey                => 'tbd',
#	yahoopartnerid                  => 'tbd',
#	yahoosubscribeuri               => 'tbd',
#	yahoo_imapurinongenericoverride => 'tbd',
#	yahoo_smtpurinongenericoverride => 'tbd',
#	yahooMessengerSharedSecret	=> '839e898ac0feece28689ed29602a1baf3b293f5c',
#	yahooMessengerConsumerKey	=> 'dj0yJmk9M29ZTTdUOU5HUlRiJmQ9WVdrOVUwMVZOMHRrTlRBbWNHbzlPVEF4T1RZMU5qWXkmcz1jb25zdW1lcnNlY3JldCZ4PTc1',
#	stage	=> post,
# }

class sngtw (	$unity_branch			= '1.0',
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
		$l_port_ug_oauth		= '3005',
		$l_port_ug_admin		= '3004',
		$l_port_ug_tauth		= '3006',
		$int_vip_common			= 'tbd',
		$int_vip_cluster		= 'tbd',
		$v_port_aaa_admin		= '3023',
		$v_port_ns_http			= '3007',
		$v_port_espws			= '3001',
		$v_port_smtp			= '25',
		$v_port_xcoder			= '3002',
		$v_port_tm			= '3026',
		$yahoodirectoauthsharedsecret   = 'tbd',
		$yahoopwtokensharedsecret       = 'tbd',
		$yahoosubscriptionsharedsecret  = 'tbd',
		$yahoonotificationsharedsecret  = 'tbd',
		$yahooconsumerkey               = 'tbd',
		$yahoopartnerid                 = 'tbd',
		$yahoosubscribeuri              = 'tbd',
		$yahoo_imapurinongenericoverride= 'tbd',
		$yahoo_smtpurinongenericoverride= 'tbd',
		$yahooMessengerSharedSecret	= '839e898ac0feece28689ed29602a1baf3b293f5c',
		$yahooMessengerConsumerKey	= 'dj0yJmk9M29ZTTdUOU5HUlRiJmQ9WVdrOVUwMVZOMHRrTlRBbWNHbzlPVEF4T1RZMU5qWXkmcz1jb25zdW1lcnNlY3JldCZ4PTc1' ) {

	include sngtw::install, sngtw::config, sngtw::service

} # End of class sngtw
