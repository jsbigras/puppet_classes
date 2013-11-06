# Global variables common at Terremark
# ------------------------------------
node 'global' {

	$g_dns_servers		= [ '10.223.204.70', '10.223.204.71' ]		        # DNS server that will populare /etc/resolv.conf
	$g_syslog_server	= '10.223.204.240'					# Syslog server
	$g_operations_email	= 'soc.support@myriadgroup.com'				# Operations email address
	$g_soc_email		= 'soc.support@myriadgroup.com'				# SOC email address
	$g_yum_server1		= '10.223.204.16'					# Yum servers
}
