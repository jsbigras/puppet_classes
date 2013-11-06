# Class: espws
# This module install the unity espws and monit on the server.
#
# Parameters:
#
# $unity_branch: The unity branch number
# $unity_branch		= '1.0'
#
# $heap: The unity component heap value
# $heap			= '512'
#
# $offheap: The unity component offheap value
# $offheap		= '1536'
#
# $port_snmp: The unity component SNMP listening port
# $port_snmp = '4000'
#
# $snmp_receiver_ip: The IP where we send the trap
# $snmp_receiver_ip = '<nagios server ip>'
#
# $v_port_espws: Listening port for the espws.
# $v_port_espws = '3001'
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
# $descNamePerNC: OperatorName --> "Description name associated to the network code".
# $descNamePerNC = [],
#
# $networkCode: Network code.
# $networkCode = [],
#
# $facebookMyriadUpdate: Facebook's MU flag
# $facebookMyriadUpdate = [],
#
# $facebookAndroid: Facebook's Android flag
# $facebookAndroid = [],
#
# $facebookRomeo: Facebook's Romeo flag
# $facebookRomeo = [],
#
# $facebookMRE: Facebook's MRE flag
# $facebookMRE = [],
#
# $facebookoauthapikey: WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
# $facebookoauthapikey = [],
#
# $facebookoauthsecretkey: WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
# $facebookoauthsecretkey = [],
#
# $twitterMyriadUpdate: twitter's MU flag
# $twitterMyriadUpdate = [],
#
# $twitterAndroid: twitter's Android flag
# $twitterAndroid = [],
#
# $twitterRomeo: twitter's Romeo flag
# $twitterRomeo = [],
#
# $twitterMRE: twitter's MRE flag
# $twitterMRE = [],
#
# $twitteroauthconsumerkey: WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
# $twitteroauthconsumerkey= [],
#
# $twitteroauthconsumersecret: WEBREDIRECT - .*Android.*|.*MRE.*|.*Romeo.* - Per Orperator/Per Hosting Center/Per environments?!?
# $twitteroauthconsumersecret= [],
#
# $facebookapikey: Basic - Myriad-Update - for all environments.
# $facebookapikey = '156220101108211',
#
# $facebooksecretkey: Basic - Myriad-Update - for all environments.
# $facebooksecretkey = 'c3ca18cb031902f82697d96bdabee2aa',
#
# $twitterconsumerkey: Basic - Myriad-Update - for all environments
# $twitterconsumerkey = 'djZv4sYbtz8tgE6LMpKaHg'
#
# $twitterconsumersecret: Basic - Myriad-Update - for all environments
# $twitterconsumersecret = 'z5DMja3qHxc9TNsHyqsxPEf1QvHgOvPBNlqQAF3BqHI',
#
# $webServerUri: FQDN necessary which allow the client to reach the web redirector.
# $webServerUri = [],
#
# Sample usage:
#
# class { espws:
#	unity_branch		=> '1.0',
#	heap			=> '512',
#	offheap			=> '1536',
#	port_snmp		=> '4000',
#	snmp_receiver_ip	=> '172.16.36.105',
#	v_port_tm		=> '3001',
#	db_master		=> 'tbd'
#	db_slave		=> 'tbd'
#	db_pwd			=> 'tbd'
#	sch_pwd			=> 'tbd'
#	sch_sql_col_tbl		=> 'tbd'
#       operatorName            => [],
#	descNamePerNC		=> [],
#	networkCode		=> [],
#	facebookMyriadUpdate	=> [],
#	facebookAndroid		=> [],
#	facebookRomeo		=> [],
#	facebookMRE		=> [],
#	facebookoauthapikey	=> [],
#	facebookoauthsecretkey	=> [],
#	twitterMyriadUpdate	=> [],
#	twitterAndroid		=> [],
#	twitterRomeo		=> [],
#	twitterMRE		=> [],
#	twitteroauthconsumerkey => [],
#	twitteroauthconsumersecret=> [],
#	facebookapikey		=> '156220101108211',
#	facebooksecretkey	=> 'c3ca18cb031902f82697d96bdabee2aa',
#	twitterconsumerkey	=> 'djZv4sYbtz8tgE6LMpKaHg'
#	twitterconsumersecret	=> 'z5DMja3qHxc9TNsHyqsxPEf1QvHgOvPBNlqQAF3BqHI',
#	webServerUri		=> [],
#	stage			=> post,
# }

class espws	 (	$unity_branch		= '1.0',
			$heap			= '512',
			$offheap		= '1536',
			$port_snmp		= '4000',
			$snmp_receiver_ip	= '172.16.36.105',
			$v_port_espws		= '3001',
			$db_master		= 'tbd',
			$db_slave		= 'tbd',
			$db_pwd			= 'tbd',
			$sch_pwd		= 'tbd',
			$sch_sql_col_tbl	= [],
			$operatorName		= [],
			$descNamePerNC		= [],
			$networkCode		= [],
			$facebookMyriadUpdate	= [],
			$facebookAndroid	= [],
			$facebookRomeo		= [],
			$facebookMRE		= [],
			$facebookoauthapikey	= [],
			$facebookoauthsecretkey	= [],
			$twitterMyriadUpdate	= [],
			$twitterAndroid		= [],
			$twitterRomeo		= [],
			$twitterMRE		= [],
			$twitteroauthconsumerkey= [],
			$twitteroauthconsumersecret= [],
			$facebookapikey		= '156220101108211',
			$facebooksecretkey	= 'c3ca18cb031902f82697d96bdabee2aa',
			$twitterconsumerkey	= 'djZv4sYbtz8tgE6LMpKaHg',
			$twitterconsumersecret	= 'z5DMja3qHxc9TNsHyqsxPEf1QvHgOvPBNlqQAF3BqHI',
			$webServerUri		= [] ) {

	include espws::install, espws::config, espws::service

} # End of class espws
