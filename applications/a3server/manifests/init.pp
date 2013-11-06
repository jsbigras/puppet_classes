# Class: a3server
# This module install the unity a3server and monit on the server.
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
# $l_port_aaa_bouncer: Listening port for bouncer interface.
# $l_port_aaa_bouncer = '3022'
#
# $l_port_aaa_oauth: Listening port for oauth interface.
# $l_port_aaa_oauth = '3024'
#
# $l_port_aaa_admin: Listening port for admin interface.
# $l_port_aaa_admin = '3023'
#
# $l_port_aaa_tauth: Listening port for tauth interface.
# $l_port_aaa_tauth = '3025'
#
# $int_vip_common: Alias used to reach the common virtual IP.
# $int_vip_common = 'tbd'
#
# $int_vip_cluster: Alias used to reach the cluster virtual IP.
# $int_vip_cluster = 'tbd'
#
# $v_port_ns_http: Port associated to NS on the LB.
# $v_port_ns_http = '3007'
#
# $v_port_subms_aaa: Port associated to subms on the LB.
# $v_port_subms_aaa = '3018'
#
# $v_port_imps_be: Port associated to IMPS BE on the LB.
# $v_port_imps_be = '3013'
#
# $v_port_ug_admin: Port associated to UG admin on the LB.
# $v_port_ug_admin = '3004'
#
# $db_master: Master DB.
# $db_master = 'tbd'
#
# $db_slave: Slave DB.
# $db_slave = 'tbd'
#
# $db_pwd: Database root password.
# $db_pwd = 'tbd'
#
# $sch_pwd: Schema password.
# $sch_pwd = 'tbd'
#
# $sch_sql_col_tbl: Schema name, script, colomn and table.
# $sch_sql_col_tbl = []
#
# $operatorName: The name of the operator to be configured.
# $operatorName = []
#
# $validateMsisdn: Request MSISDN normalization.(true|false).
# $validateMsisdn = []
#
# $idField: Determines the field used for the accountId.(msisdn|imei|imsi|deviceid|guid).
# $idField = []
#
# $obfuscateId: Determines if the idField must be obfuscated (i.e. MD5) before returned as accountId.(true|false).
# $obfuscateId = []
#
# $bouncerCodecRefid: Id of the associated bouncer-codec.(msisdn-bouncer|imei-bouncer|imsi-bouncer|deviceid-bouncer|guid-bouncer).
# $bouncerCodecRefid = []
#
# $bouncerHeader: HTTP header name used to carry the accountId information.
# $bouncerHeader = []
#
# $imps_domain: Domain configured in the IMPS server.
# $imps_domain = []
#
# $imps_alias: Alias associated to the internal VIP used to reach a customer specific IMPS server.
# $imps_alias = []
#
# $handlerType: "trust-all-fields"(no authentification), "no-op" (sms pin authentification), "subms".
# $handlerType = []
#
# $countryid: Country where operator is located. 
# $countryid = []
#
# $country_code: Must be specified in the country-code.xml.
# $country_code = []
#
# $national_prefix: http://www.howtocallabroad.com/
# $national_prefix = []
#
# $national_prefix_required: Indicates whether, according to the local dialing practices, a user will normally include the national prefix.
# $national_prefix_required = []
#
# $validate_country: Indicates whether the AAA server must check and validate whether the MSISDN provided by the users device has the MCC specified in the country-code attribute of the msisdn-format element.
# $validate_country = []
#
# $descNamePerNC: OperatorName --> "Description name associated to the network code".
# $descNamePerNC = []
#
# $networkCode: Network code.
# $networkCode = []
#
# $msisdnValidatorRefid: Country where operator is located.
# $msisdnValidatorRefid = []
#
# $timestampValidityRangeSeconds : By default it is set to 600 (seconds). Validate the timestamp of every signature request against the server time. Reject it if time difference is greater then value specify.
# $timestampValidityRangeSeconds = '600'
#
# $eviction_job_start_gmt: Hour space minute of when the eviction job will run.
# $eviction_job_start_gmt = []
#
# $ottCode: ott-clients Network code.
# $ottCode = 'tbd' 
#
# Sample usage:
#
# class { a3server:
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
#	l_port_aaa_bouncer		=> '3022',
#	l_port_aaa_oauth		=> '3024,
#	l_port_aaa_admin		=> '3023',
#	l_port_aaa_tauth		=> '3025',
#	int_vip_common			=> 'tbd',
#	int_vip_cluster			=> 'tbd',
#	v_port_ns_http			=> '3007',
#	v_port_subms_aaa		=> '3018',
#	v_port_imps_be			=> '3013',
#	v_port_ug_admin			=> '3004',
#	db_master			=> 'tbd',
#	db_slave			=> 'tbd',
#	db_pwd				=> 'tbd',
#	sch_pwd				=> 'tbd',
#	sch_sql_col_tbl			=> [],
#	operatorName			=> [],
#	validateMsisdn			=> [],
#	idField				=> [],
#	obfuscateId			=> [],
#	bouncerCodecRefid		=> [],
#	bouncerHeader			=> [],
#	imps_domain			=> [],
#	imps_alias			=> [],
#	handlerType			=> [],
#	countryid			=> [],
#	country_code			=> [],
#	national_prefix			=> [],
#	national_prefix_required	=> [],
#	validate_country		=> [],
#	descNamePerNC			=> [],
#	networkCode			=> [],
#	msisdnValidatorRefid		=> [],
#	timestampValidityRangeSeconds	=> '600',
#	eviction_job_start_gmt		=> [],
#	ottCode				=> 'tbd',
#	stage	=> post,
# }

class a3server (	$unity_branch			= '1.0',
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
			$l_port_aaa_bouncer		= '3022',
			$l_port_aaa_oauth		= '3024',
			$l_port_aaa_admin		= '3023',
			$l_port_aaa_tauth		= '3025',
			$int_vip_common			= 'tbd',
			$int_vip_cluster		= 'tbd',
			$v_port_ns_http			= '3007',
			$v_port_subms_aaa		= '3018',
			$v_port_imps_be			= '3013',
			$v_port_ug_admin		= '3004',
			$db_master			= 'tbd',
			$db_slave			= 'tbd',
			$db_pwd				= 'tbd',
			$sch_pwd			= 'tbd',
			$sch_sql_col_tbl		= [],
			$operatorName			= [],
			$validateMsisdn			= [],
			$idField			= [],
			$obfuscateId			= [],
			$bouncerCodecRefid		= [],
			$bouncerHeader			= [],
			$imps_domain			= [],
			$imps_alias			= [],
			$handlerType			= [],
			$countryid			= [],
			$country_code			= [],
			$national_prefix		= [],
			$national_prefix_required	= [],
			$validate_country		= [],
			$descNamePerNC			= [],
			$networkCode			= [],
			$msisdnValidatorRefid		= [],
			$timestampValidityRangeSeconds	= '600',
			$eviction_job_start_gmt		= [],
			$ottCode			= 'tbd' ) {

	include a3server::install, a3server::config, a3server::service

} # End of class a3server
