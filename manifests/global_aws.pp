# Global variables common at AWS
# ------------------------------
node 'global_aws' {

#	$g_dns_servers		= [ '192.168.130.101', '192.168.130.102' ]		# DNS server that will populare /etc/resolv.conf
#	$g_ntp_servers		= [ '172.16.36.58', '172.16.36.154' ]			# NTP servers on whic the server will sync
#	$g_syslog_server	= 'syslog'						# Syslog server
#	$g_rwcommunity		= '0zsnmp0'						# SNMP read/write community
#	$g_rocommunity		= '0zsnmp0'						# SNMP read-only community
#	$g_trapcommunity	= '0zsnmp0'						# Trap community
	$g_trapdestination	= '127.0.0.1'						# Trap destination
#	$g_snmp_servers		= [ '172.16.36.131', '172.16.36.132', '172.16.36.105' ]	# SNMP servers
#	$g_operations_email	= 'soc.support@myriadgroup.com'				# Operations email address
#	$g_soc_email		= 'soc.support@myriadgroup.com'				# SOC email address
#	$g_mailrelay		= 'mailhost'						# Mail relay server
#	$g_mc_server		= 'suwpuppet01.mt2.suw.hostings.ops'			# mcollective server
#	$g_mc_user		= 'mcollective'						# mcollective username
#	$g_mc_password		= 'marionette'						# mcollective password
	$g_yum_server1		= 'ip-172-31-37-161.ec2.internal'			# Yum servers
#	$g_auth_server1_name	= 'ad14.hosting.ops'					# Active Directory server 1 name
#	$g_auth_server1_ip	= '192.168.130.101'					# Active Directory server 1 IP
#	$g_auth_server2_name	= 'ad16.hosting.ops'					# Active Directory server 2 name
#	$g_auth_server2_ip	= '192.168.130.102'					# Active Directory server 2 IP
#	$g_ou			= 'mt2'							# Active Directory OU
}
