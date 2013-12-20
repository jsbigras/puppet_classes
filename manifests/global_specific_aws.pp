node 'global_specific_aws' inherits global_aws  {

	# Application global variables
	# ========================================

	# Common to all Unity Components		
	# -----------------------
	$g_cdw_srv				= ['n/a','n/a']					# CDW server IP which will handle the files.
	$g_cdw_usr				= 'n/a'						# Prereq: You must create this user
	$g_cdw_passwd				= 'n/a'						# Prereq: You must create this user
	$g_cdw_path_cluster			= 'n/a'						# Location where files will be transfered for the cluster components.
	$g_int_vip_common			= 'aws-v-int'					# Alias used to reach the common virtual IP
	$g_int_vip_cluster			= 'aws-v-int'					# Alias used to reach the cluster virtual IP
	$g_maxfileidle				= '1'						# In HOURS (/opt/nokia/nmp/conf/transactionrecords.xml)
	$g_maxfilestale				= '12'						# In HOURS (/opt/nokia/nmp/conf/transactionrecords.xml)
	$g_port_monit				= '3000'					# Monit listening port
	$g_port_snmp1				= '4000'					# SNMP port common on all components
	$g_port_snmp2				= '4001'					# SNMP port used for the nmpcachepeer component
	$g_snmp_receiver_ip			= '127.0.0.1'					# This is the ip address of the nagios server where the nodes are monitored.

	# Module specific
	# -----------------------
	$g_a3server_ottCode			= '99710'					# ott-clients Network code
	$g_a3server_timestampValidityRangeSeconds = '600'					# By default it is set to 600 (seconds). Validate the timestamp of every signature request against the server time. Reject it if time difference is greater then value specify.
	$g_a3server_eviction_job_start_gmt	= [1,0]				 		# Hour space minute of when the eviction job will run.
	$g_imps_multicastip			= ['239.1.1.108','239.1.1.109']
	$g_imps_multicastport			= ['4001','4002']
	$g_notifications_tokensmemmaxsize	= '30000'					# This is the value for the tokens local cache on the notifications server.
	$g_cstore_tokensmemmaxsize		= '2000'					# This is the value for the tokens local cache on the notifications server. Production value is 10000.
	$g_notifications_includeFromShortcode	= 'false'					# Include or not shortcode in the SMS request.
	$g_notifications_shortcode		= '12345'					# Carrier shortcode.
	
	# Plugins specific
	# -----------------------
	$g_gcm_senderid				= '640094940223'				# Give it to the client team, https://portal.synchronica.com/nokiasites/MontrealOB/OB Messaging Shared Documentation/Operations/<carrier>/GCM_API_key.docx
	$g_gcm_apikey				= 'AIzaSyBUpv1hlGlzF1ebjjxRXnQBAYbgNY1ggKw'	# https://portal.synchronica.com/nokiasites/MontrealOB/OB Messaging Shared Documentation/Operations/<carrier>/GCM_API_key.docx
	$g_gcm_delaywhileidle			= 'false'					# https://portal.synchronica.com/nokiasites/MontrealOB/OB Messaging Shared Documentation/Operations/<carrier>/GCM_API_key.docx

	# DB specific
	# -----------------------
	$g_db_cluster_vip			= '10.33.69.89'					# DB vip in the Cluster specific
	$g_db_cluster_pwd			= 'synchronica'					# Database root password in the Cluster specific
	$g_db_common_vip			= 'ops-sandbox.ccwfrwzz5cvu.us-east-1.rds.amazonaws.com' # DB vip in the Common cluster
	$g_db_common_pwd			= 'synchronica'					# Database root password in the Common cluster
	$g_schema_pwd_cluster			= 'Demo01'					# Schemas password on the Cluster specific db
	$g_schema_pwd_common			= 'Demo01'					# Schemas password on the Common db

	$g_a3server_sch_sql_col_tbl		= ['aaa_aws',	'setup_db.sql',		'accountid',	'aaa_authorization']
	$g_cstore_sch_sql_col_tbl		= ['cstore_aws','setup_db.sql',	'productid',	'store_product']
	$g_imps_sch_sql_col_tbl			= ['imps_aws',	'n/a',			'n/a',		'n/a']
	$g_cmp_sch_sql_col_tbl			= ['cmp_aws',	'schema-setup.sql',	'buildnumber',	'version_info']

	# Heap component specific
	# -----------------------
	$g_abimport_heap			= '1024'
	$g_abimport_offheap			= '1024'
	$g_a3server_heap			= '2048'
	$g_a3server_offheap			= '1024'
	$g_cstore_heap				= '1024'
	$g_cstore_offheap			= '1024'
	$g_imps_adm_heap			= '128'
	$g_imps_app_heap			= '1024'
	$g_imps_csplb_heap			= '512'
	$g_imps_fe_heap				= '512'
	$g_nmpcache_heap			= '1024'
	$g_nmpcache_offheap			= '1024'
	$g_nmpcachepeer_heap			= '1024'
	$g_nmpcachepeer_offheap			= '1024'
	$g_notifications_heap			= '1024'
	$g_notifications_offheap		= '1024'

	# Cache IDs
	# -----------------------
	$g_cache_primary			= '10.33.69.77'
	$g_cache_secondary			= ''
	$g_cacheid_desc				=['CacheId used by sngtw, notifications, pushserver and a3server', # Components which benefit from the cacheId
						  'CacheId used by sngtw and pushserver',	# 2
						  'CacheId used by sngtw and pushserver',	# 3
						  'CacheId used by sngtw only',			# 4
						  'CacheId used by sngtw only',			# 5
						  'CacheId used by a3server only',		# 6
						  'CacheId used by romeo only',			# 7
						  'CacheId used by Myriad Store only',		# 8
						  'CacheId used by Myriad Store only']		# 9
	$g_cacheid_name				=['channel',					# cacheId name
						  'credentials',				# 2
						  'subscriptions',				# 3 
						  'mediatransfer',				# 4
						  'mailaccountknowledge',			# 5
						  'token-store',				# 6
						  'romeox',					# 7
						  'store_user_owned_data',			# 8
						  'store_product_sync']				# 9
	$g_cacheid_maxinmem			=['200000',					# maxElementsInMemoryForCluster
						  '150000',					# 2
						  '150000',					# 3
						  '20000',					# 4
						  '50000',					# 5
						  '50000',					# 6
						  '20000',					# 7
						  '10000',					# 8 in production value is 100000
						  '1000']					# 9
	$g_cacheid_verenabled			=['true',					# versioningEnabled
						  'false',					# 2
						  'false',					# 3
						  'false',					# 4
						  'false',					# 5
						  'false',					# 6
						  'false',					# 7
						  'false',					# 8
						  'false']					# 9
	$g_cacheid_hddpersist			=['synchronized',				# hddPersistent off|synchronized|batched
						  'synchronized',				# 2
						  'synchronized',				# 3
						  'off',					# 4
						  'off',					# 5
						  'off',					# 6
						  'synchronized',				# 7
						  'off',					# 8
						  'off']					# 9

	# Local ports
	# -----------------------
	$g_l_port_abimport_mo			= '3030'
	$g_l_port_aaa_bouncer			= '3022'
	$g_l_port_aaa_oauth			= '3024'
	$g_l_port_cache				= '3001'
	$g_l_port_cachepeer			= '3002'
	$g_l_port_cstore_mo			= '3130'
	$g_l_port_cmp				= '3132'
	$g_l_port_imps_fe			= '3012'
	$g_l_port_imps_adm			= '3008'
	$g_l_port_imps_web			= '3009'
	$g_l_port_kannel_http			= '3109'
	$g_l_port_ns_tcpcir			= '3717'
	$g_l_port_ns_lhttp			= '3011'
	$g_l_port_ns_loop			= '3107'

	# Internal LB ports
	# -----------------------
	$g_v_port_aaa_admin			= '3023'
	$g_v_port_aaa_tauth			= '3025'
	$g_v_port_cstore_admin			= '3131'
	$g_v_port_imps_fe			= '3012'
	$g_v_port_imps_be			= '3013'
	$g_v_port_kannel_ns			= '3104'
	$g_v_port_kannel_imps			= '3105'
	$g_v_port_kannel_subms			= '3106'
	$g_v_port_kannel_mu			= '3107'
	$g_v_port_kannel_em2sms			= '3108'
	$g_v_port_ns_http			= '3007'

	# AAA (country specific)
	# -----------------------
	$g_countryid				=['simple']					# Country where operator is located.
	$g_country_code				=['']						# Must be specified in the country-code.xml.
	$g_national_prefix			=['']						# http://www.howtocallabroad.com/
	$g_national_prefix_required		=['']						# Indicates whether, according to the local dialing practices, a user will normally include the national prefix.
	$g_validate_country			=['']						# Indicates whether the AAA server must check and validate whether the MSISDN provided by the users device has the MCC specified in the country-code attribute of the msisdn-format element.

	# AAA, Kannel and NS (operator specific)
	# -----------------------
	$g_operatorNameAll			=['catch_all']					# The name of the operator to be configured.
	$g_operatorName				=['catch_all']					# The name of the operator to be configured.
	$g_validateMsisdn			=['true']					# Request MSISDN normalization.(true|false)
	$g_idField				=['msisdn']					# Determines the field used for the accountId.(msisdn|imei|imsi|deviceid|guid)
	$g_obfuscateId				=['false']					# Determines if the idField must be obfuscated (i.e. MD5) before returned as accountId.(true|false)
	$g_bouncerCodecRefid			=['msisdn-bouncer']				# Id of the associated bouncer-codec.(msisdn-bouncer|imei-bouncer|imsi-bouncer|deviceid-bouncer|guid-bouncer)
	$g_bouncerHeader			=['x-unity-msisdn']				# HTTP header name used to carry the accountId information.
	$g_imps_domain				=['demo.unity.mobi']				# Domain configured in the IMPS server.
	$g_imps_alias				=['demo-imps-c-01.suw.hosting.ops']		# Alias associated to the internal VIP used to reach a customer specific IMPS server.
	$g_handlerType				=['no-op']					# "trust-all-fields"(no authentification), "no-op" (sms pin authentification), "subms"
	$g_kannel_username_ns			=['send']					# Kannel username for NS
	$g_kannel_password_ns			=['send']					# Kannel password for NS
	$g_facebookMyriadUpdate			=['YES']					# Facebook's MU flag
	$g_facebookAndroid			=['YES']					# Facebook's Android flag
	$g_facebookRomeo			=['YES']					# Facebook's Romeo flag
	$g_facebookMRE				=['YES']					# Facebook's MRE flag
	$g_facebookoauthapikey			=['153375971491328']				# WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
	$g_facebookoauthsecretkey		=['ec2750c018320a1b93c0853eb5165ea7']		# WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
	$g_twitterMyriadUpdate			=['YES']					# twitter's MU flag
	$g_twitterAndroid			=['YES']					# twitter's Android flag
	$g_twitterRomeo				=['YES']					# twitter's Romeo flag
	$g_twitterMRE				=['YES']					# twitter's MRE flag
	$g_twitteroauthconsumerkey		=['Xxb0Q4awkq7n6EBHqSTecQ']			# WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
	$g_twitteroauthconsumersecret		=['G78GNcMeW38xoVoAK7u2FwpUBCBbGzRGpm9KxBCoSg']	# WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
	$g_webServerUri				=['demo-ug-c-01.unity.mobi']			# FQDN necessary which allow the client to reach the web redirector.

	# AAA, PFS and NS (network code specific)
	# -----------------------
	$g_descNamePerNCAll			=['catch_all : catch_all']			# OperatorName --> "Description name associated to the network code".
	$g_descNamePerNC			=['catch_all : catch_all']			# OperatorName --> "Description name associated to the network code".
	$g_networkCodeAll			=['111111']					# Network code.
	$g_networkCode				=['111111']					# Network code.
	$g_msisdnValidatorRefid			=['simple']					# Country where the network code is assigned.

}
