# Class: kannel
# This module install the unity kannel and monit on the server.
#
# Parameters:
#
# $unity_branch: The unity branch number
# $unity_branch		= '1.0'
#
# $port_monit: Listening port for monit.
# $port_monit		= '3000'
#
# $v_port_kannel_http: Listening port for http traffic.
# $v_port_kannel_http	= '3009'
#
# $v_port_kannel_ns: Listening port fro NS traffic..
# $v_port_kannel_ns	= '3004'
#
# $v_port_kannel_imps: Listening port for imps traffic..
# $v_port_kannel_imps	= '3005'
#
# $v_port_kannel_subms: Listening port for subms traffic..
# $v_port_kannel_subms	= '3006'
#
# $v_port_kannel_mu: Listening port for mu traffic..
# $v_port_kannel_mu	= '3007'
#
# $v_port_kannel_em2sms: Listening port for em2sms traffic..
# $v_port_kannel_em2sms	= '3008'
#
# $kannel_username_1: SendSMS User.
# $kannel_username_1	= 'send'
#
# $kannel_password_1: SendSMS Password.
# $kannel_password_1	= 'send'
#
# Sample usage:
#
# class { kannel:
#	unity_branch		=> '1.0',
#	port_monit		=> '3000',
#	v_port_kannel_ns	=> '3004',
#	v_port_kannel_imps	=> '3005',
#	v_port_kannel_subms	=> '3006',
#	v_port_kannel_mu	=> '3007',
#	v_port_kannel_em2sms	=> '3008',
#	kannel_username_1	=> 'send',
#	kannel_password_1	=> 'send',
#	stage			=> post,
# }

class kannel (		$unity_branch		= '1.0',
			$port_monit		= '3000',
			$l_port_kannel_http	= '3009',
			$v_port_kannel_ns	= '3004',
			$v_port_kannel_imps	= '3005',
			$v_port_kannel_subms	= '3006',
			$v_port_kannel_mu	= '3007',
			$v_port_kannel_em2sms	= '3008',
			$kannel_username_1	= 'send',
			$kannel_password_1	= 'send' ) {

	include kannel::install, kannel::config, kannel::service

} # End of class kannel
