# Class: pushserver
# This module install the unity pushserver and monit on the server.
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
# $espmemmaxsize: This is the value for the esp local cache on the push server.
# $espmemmaxsize = '30000'
#
# $l_port_ps: Listening port for traffic coming from the TM.
# $l_port_ps = '3013'
#
# $l_port_ps_tool: Listening port for TOOL interface.
# $l_port_ps_tool = '3101'
#
# $l_port_ps_yahoo: Listening port for Yahoo notifs.
# $l_port_ps_yahoo = '3001'
#
# $l_port_ps_ews: Listening port for EWS notifs.
# $l_port_ps_ews = '3002'
#
# $l_port_farm: Port used by PS and TM for the farm
# $l_port_farm = '3020'
#
# $notifurl: URL portal must be using to send the notifs back to the PS.
# $notifurl = 'tbd'
#
# $notifport: Port portal must be using to send the notifs back to the PS. 
# $notifport = '80'
#
# $maxPollingSpreadBufferInSeconds: Max Polling Spread Buffer In Seconds.
# $maxPollingSpreadBufferInSeconds = '600'
#
# $int_vip_common: Alias used to reach the common virtual IP.
# $int_vip_common = 'tbd'
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
#
# $v_port_espws: Port associated to ESPWS on the LB.
# $v_port_espws = '3001'
#
# $v_port_ns_http: Port associated to NS on the LB.
# $v_port_ns_http = '3007'
#
# $taskmanager_cluste: Array composed of all the TM IPs in the cluster.
# $taskmanager_cluster    = 'tbd'
#
# $pushserver_cluster: Array composed of all the PS IPs in the cluster.
# $pushserver_cluster     = 'tbd'
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
# Sample usage:
#
# class { pushserver:
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
#	espmemmaxsize			=> '30000',
#	l_port_ps			=> '3013',
#	l_port_ps_tool			=> '3101',
#	l_port_ps_yahoo			=> '3001',
#	l_port_ps_ews			=> '3002',
#	l_port_farm			=> '3020',
#	notifurl			=> 'tbd',
#	notifport			=> '80',
#	maxPollingSpreadBufferInSeconds => '600',
#	int_vip_common			=> 'tbd',
#	int_vip_cluster			=> 'tbd',
#	v_port_espws			=> '3001',
#	v_port_ns_http			=> '3007',
#	taskmanager_cluster		=> 'tbd',
#	pushserver_cluster		=> 'tbd',
#	yahoodirectoauthsharedsecret	=> 'tbd',
#	yahoopwtokensharedsecret	=> 'tbd',
#	yahoosubscriptionsharedsecret	=> 'tbd',
#	yahoonotificationsharedsecret	=> 'tbd',
#	yahooconsumerkey		=> 'tbd',
#	yahoopartnerid			=> 'tbd',
#	yahoosubscribeuri		=> 'tbd',
#	yahoo_imapurinongenericoverride	=> 'tbd',
#	yahoo_smtpurinongenericoverride	=> 'tbd', 
#	stage	=> post,
# }

class pushserver (	$unity_branch			= '1.0',
			$heap				= '1024',
			$offheap		 	= '1024',
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
			$espmemmaxsize			= '30000',
			$l_port_ps			= '3013',
			$l_port_ps_tool			= '3101',
			$l_port_ps_yahoo		= '3001',
			$l_port_ps_ews			= '3002',
			$l_port_farm			= '3020',
			$notifurl			= 'tbd',
			$notifport			= '80',
			$maxPollingSpreadBufferInSeconds = '600',
			$int_vip_common			= 'tbd',
			$int_vip_cluster		= 'tbd',
			$v_port_espws			= '3001',
			$v_port_ns_http			= '3007',
			$taskmanager_cluster		= 'tbd',
			$pushserver_cluster		= 'tbd',
			$yahoodirectoauthsharedsecret	= 'tbd',
			$yahoopwtokensharedsecret	= 'tbd',
			$yahoosubscriptionsharedsecret	= 'tbd',
			$yahoonotificationsharedsecret	= 'tbd',
			$yahooconsumerkey		= 'tbd',
			$yahoopartnerid			= 'tbd',
			$yahoosubscribeuri		= 'tbd',
			$yahoo_imapurinongenericoverride= 'tbd',
			$yahoo_smtpurinongenericoverride= 'tbd' ) {

	include pushserver::install, pushserver::config, pushserver::service

} # End of class pushserver
