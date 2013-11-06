class role_webredirect {

        class { 'httpd':
                stage                   => post,
        }
        class { 'webredirect':
                stage                   => post,
        }
}

class role_ug_new {

        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { sngtw:
                unity_branch            => $s_unity_branch,
                heap                    => $g_sngtw_heap,
                offheap                 => $g_sngtw_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		l_port_cache		=> $g_l_port_cache,
		cache_primary           => $g_cache_primary,
		cache_secondary         => $g_cache_secondary,
		cacheid_desc            => $g_cacheid_desc,
                cacheid_name            => $g_cacheid_name,
                cacheid_maxinmem        => $g_cacheid_maxinmem,
                cacheid_verenabled      => $g_cacheid_verenabled,
                cacheid_hddpersist      => $g_cacheid_hddpersist,
		l_port_ug_oauth		=> $g_l_port_ug_oauth,
		l_port_ug_admin		=> $g_v_port_ug_admin,
		l_port_ug_tauth		=> $g_v_port_ug_tauth,
		int_vip_common		=> $g_int_vip_common,
		int_vip_cluster		=> $g_int_vip_cluster,
		v_port_aaa_admin	=> $g_v_port_aaa_admin,
		v_port_ns_http		=> $g_v_port_ns_http,
		v_port_espws		=> $g_v_port_espws,
		v_port_smtp		=> $g_v_port_smtp,
		v_port_xcoder		=> $g_v_port_xcoder,
		v_port_tm		=> $g_v_port_tm,
		yahoodirectoauthsharedsecret           => $g_yahoodirectoauthsharedsecret,
		yahoopwtokensharedsecret               => $g_yahoopwtokensharedsecret,
		yahoosubscriptionsharedsecret          => $g_yahoosubscriptionsharedsecret,
		yahoonotificationsharedsecret          => $g_yahoonotificationsharedsecret,
		yahooconsumerkey                       => $g_yahooconsumerkey,
		yahoopartnerid                         => $g_yahoopartnerid,
		yahoosubscribeuri                      => $g_yahoosubscribeuri,
		yahoo_imapurinongenericoverride        => $g_yahoo_imapurinongenericoverride,
		yahoo_smtpurinongenericoverride        => $g_yahoo_smtpurinongenericoverride,
		stage                   => post,
        }
}

class role_cache_new {

	class { platform:
		port_monit		=> $g_port_monit,
		maxfileidle		=> $g_maxfileidle,
		maxfilestale		=> $g_maxfilestale,
		stage			=> post,
	}
	class { nmpcache:
		unity_branch		=> $s_unity_branch,
		heap			=> $g_nmpcache_heap,
		offheap			=> $g_nmpcache_offheap,
		port_snmp		=> $g_port_snmp1,
		snmp_receiver_ip	=> $g_snmp_receiver_ip,
		l_port_cache		=> $g_l_port_cache,
		cache_primary		=> $g_cache_primary,
		cache_secondary		=> $g_cache_secondary,
		cacheid_desc		=> $g_cacheid_desc,
		cacheid_name		=> $g_cacheid_name,
		cacheid_maxinmem	=> $g_cacheid_maxinmem,
		cacheid_verenabled	=> $g_cacheid_verenabled,
		cacheid_hddpersist	=> $g_cacheid_hddpersist,
		stage			=> post,
	}
}

class role_db_new {

	class { 'mysql::server':
		stage                   => post,
	}
}

class role_espws_new {

	class { mysql:
		stage                   => post,
	}
        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { espws:
                unity_branch            => $s_unity_branch,
                heap                    => $g_espws_heap,
                offheap                 => $g_espws_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		v_port_espws		=> $g_v_port_espws,
		db_master		=> $g_db_common_master,
		db_slave		=> $g_db_common_slave,
		db_pwd			=> $g_db_common_pwd,
		sch_pwd			=> $g_schema_pwd_common,
		sch_sql_col_tbl		=> $g_espws_sch_sql_col_tbl,
		operatorName		=> $g_operatorNameAll,
		descNamePerNC		=> $g_descNamePerNCAll,
		networkCode		=> $g_networkCodeAll,
		facebookMyriadUpdate    => $g_facebookMyriadUpdate,
		facebookAndroid         => $g_facebookAndroid,
		facebookRomeo           => $g_facebookRomeo,
		facebookMRE             => $g_facebookMRE,
		facebookoauthapikey     => $g_facebookoauthapikey,
		facebookoauthsecretkey  => $g_facebookoauthsecretkey,
		twitterMyriadUpdate     => $g_twitterMyriadUpdate,
		twitterAndroid          => $g_twitterAndroid,
		twitterRomeo            => $g_twitterRomeo,
		twitterMRE              => $g_twitterMRE,
		twitteroauthconsumerkey=> $g_twitteroauthconsumerkey,
		twitteroauthconsumersecret=> $g_twitteroauthconsumersecret,
		facebookapikey          => $g_facebookapikey,
		facebooksecretkey       => $g_facebooksecretkey,
		twitterconsumerkey      => $g_twitterconsumerkey,
		twitterconsumersecret   => $g_twitterconsumersecret,
		webServerUri            => $g_webServerUri,
		stage                   => post,
        }
}

class role_postfix_new {

	class { postfix_new: 
		postfix_myhostname	=> $g_postfix_myhostname,
		postfix_mynetworks	=> $g_postfix_mynetworks,
		postfix_inet_interfaces	=> $hostname,
		stage                   => post,
	}
}

class role_xcoder_new {

	class { platform:
		port_monit		=> $g_port_monit,
		maxfileidle		=> $g_maxfileidle,
		maxfilestale		=> $g_maxfilestale,
		stage			=> post,
	}
	class { nmptranscoder:
		unity_branch		=> $s_unity_branch,
		heap			=> $g_nmptranscoder_heap,
		offheap			=> $g_nmptranscoder_offheap,
		port_snmp		=> $g_port_snmp1,
		snmp_receiver_ip	=> $g_snmp_receiver_ip,
		v_port_xcoder		=> $g_v_port_xcoder,
		stage                   => post,
	}
}

class role_tm_new {

	class { mysql:
		stage                   => post,
	}
        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { nmptaskmanager:
                unity_branch            => $s_unity_branch,
                heap                    => $g_nmptaskmanager_heap,
                offheap                 => $g_nmptaskmanager_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		v_port_tm		=> $g_v_port_tm,
		taskmanager_cluster	=> $g_taskmanager_cluster,
		pushserver_cluster	=> $g_pushserver_cluster,
		l_port_farm		=> $g_l_port_farm,
		db_master		=> $g_db_cluster_master,
		db_slave		=> $g_db_cluster_slave,
		db_pwd			=> $g_db_cluster_pwd,
		sch_pwd			=> $g_schema_pwd_cluster,
		sch_sql_col_tbl		=> $g_nmptaskmanager_sch_sql_col_tbl,
		stage                   => post,
        }
}

class role_ps_new {

        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { pushserver:
                unity_branch            => $s_unity_branch,
                heap                    => $g_pushserver_heap,
                offheap                 => $g_pushserver_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		l_port_cache		=> $g_l_port_cache,
		cache_primary           => $g_cache_primary,
		cache_secondary         => $g_cache_secondary,
		cacheid_desc            => $g_cacheid_desc,
                cacheid_name            => $g_cacheid_name,
                cacheid_maxinmem        => $g_cacheid_maxinmem,
                cacheid_verenabled      => $g_cacheid_verenabled,
                cacheid_hddpersist      => $g_cacheid_hddpersist,
		espmemmaxsize		=> $g_pushserver_espmemmaxsize,
		l_port_ps		=> $g_l_port_ps,
		l_port_ps_tool		=> $g_l_port_ps_tool,
		l_port_ps_yahoo		=> $g_l_port_ps_yahoo,
		l_port_ps_ews		=> $g_l_port_ps_ews,
		l_port_farm		=> $g_l_port_farm,
		notifurl		=> $g_pushserver_notifurl,
		notifport		=> $g_pushserver_notifport,
		maxPollingSpreadBufferInSeconds	=> $g_pushserver_maxPollingSpreadBufferInSeconds,
		int_vip_common		=> $g_int_vip_common,
		int_vip_cluster		=> $g_int_vip_cluster,
		v_port_espws		=> $g_v_port_espws,
		v_port_ns_http		=> $g_v_port_ns_http,
		taskmanager_cluster	=> $g_taskmanager_cluster,
		pushserver_cluster	=> $g_pushserver_cluster,
		yahoodirectoauthsharedsecret           => $g_yahoodirectoauthsharedsecret,
		yahoopwtokensharedsecret               => $g_yahoopwtokensharedsecret,
		yahoosubscriptionsharedsecret          => $g_yahoosubscriptionsharedsecret,
		yahoonotificationsharedsecret          => $g_yahoonotificationsharedsecret,
		yahooconsumerkey                       => $g_yahooconsumerkey,
		yahoopartnerid                         => $g_yahoopartnerid,
		yahoosubscribeuri                      => $g_yahoosubscribeuri,
		yahoo_imapurinongenericoverride        => $g_yahoo_imapurinongenericoverride,
		yahoo_smtpurinongenericoverride        => $g_yahoo_smtpurinongenericoverride,
		stage                   => post,
        }
}

class role_ns_new {

        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { notifications:
                unity_branch            => $s_unity_branch,
                heap                    => $g_notifications_heap,
                offheap                 => $g_notifications_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		l_port_cache		=> $g_l_port_cache,
		cache_primary           => $g_cache_primary,
		cache_secondary         => $g_cache_secondary,
		cacheid_desc            => $g_cacheid_desc,
                cacheid_name            => $g_cacheid_name,
                cacheid_maxinmem        => $g_cacheid_maxinmem,
                cacheid_verenabled      => $g_cacheid_verenabled,
                cacheid_hddpersist      => $g_cacheid_hddpersist,
		tokensmemmaxsize	=> $g_notifications_tokensmemmaxsize,
		includeFromShortcode	=> $g_notifications_includeFromShortcode,
		shortcode		=> $g_notifications_shortcode,
		l_port_ns_tcpcir	=> $g_l_port_ns_tcpcir,
		l_port_ns_lhttp		=> $g_l_port_ns_lhttp,
		l_port_ns_loop		=> $g_l_port_ns_loop,
		l_port_ns_http		=> $g_v_port_ns_http,
		int_vip_common		=> $g_int_vip_common,
		int_vip_cluster		=> $g_int_vip_cluster,
		v_port_mu_ns		=> $g_v_port_mu_ns,
		v_port_em2sms		=> $g_v_port_em2sms,
		v_port_kannel_ns	=> $g_v_port_kannel_ns,
		v_port_aaa_admin	=> $g_v_port_aaa_admin,
		gcm_apikey		=> $g_gcm_apikey,
		gcm_delaywhileidle	=> $g_gcm_delaywhileidle,
		descNamePerNC		=> $g_descNamePerNC,
		networkCode		=> $g_networkCode,
		operatorName		=> $g_operatorName,
		kannel_username		=> $g_kannel_username_ns,
		kannel_password		=> $g_kannel_password_ns,
		stage                   => post,
        }
}

class role_aaa_new {

	class { mysql:
		stage                   => post,
	}
        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
	class { a3server:
		unity_branch		=> $s_unity_branch,
		heap			=> $g_a3server_heap,
		offheap			=> $g_a3server_offheap,
		port_snmp		=> $g_port_snmp1,
		snmp_receiver_ip	=> $g_snmp_receiver_ip,
		l_port_cache		=> $g_l_port_cache,
		cache_primary		=> $g_cache_primary,
		cache_secondary		=> $g_cache_secondary,
		cacheid_desc		=> $g_cacheid_desc,
		cacheid_name		=> $g_cacheid_name,
		cacheid_maxinmem	=> $g_cacheid_maxinmem,
		cacheid_verenabled	=> $g_cacheid_verenabled,
		cacheid_hddpersist	=> $g_cacheid_hddpersist,
		l_port_aaa_bouncer	=> $g_l_port_aaa_bouncer,
		l_port_aaa_oauth	=> $g_l_port_aaa_oauth,
		l_port_aaa_admin	=> $g_v_port_aaa_admin,
		l_port_aaa_tauth	=> $g_v_port_aaa_tauth,
		int_vip_common		=> $g_int_vip_common,
		int_vip_cluster		=> $g_int_vip_cluster,
		v_port_ns_http		=> $g_v_port_ns_http,
		v_port_subms_aaa	=> $g_v_port_subms_aaa,
		v_port_imps_be		=> $g_v_port_imps_be,
		v_port_ug_admin		=> $g_v_port_ug_admin,
		db_master		=> $g_db_cluster_master,
		db_slave		=> $g_db_cluster_slave,
		db_pwd			=> $g_db_cluster_pwd,
		sch_pwd			=> $g_schema_pwd_cluster,
		sch_sql_col_tbl		=> $g_a3server_sch_sql_col_tbl,
		operatorName		=> $g_operatorName,
		validateMsisdn		=> $g_validateMsisdn,
		idField			=> $g_idField,
		obfuscateId		=> $g_obfuscateId,
		bouncerCodecRefid	=> $g_bouncerCodecRefid,
		bouncerHeader		=> $g_bouncerHeader,
		imps_domain		=> $g_imps_domain,
		imps_alias		=> $g_imps_alias,
		handlerType		=> $g_handlerType,
		countryid		=> $g_countryid,
		country_code		=> $g_country_code,
		national_prefix		=> $g_national_prefix,
		national_prefix_required=> $g_national_prefix_required,
		validate_country	=> $g_validate_country,
		descNamePerNC		=> $g_descNamePerNC,
		networkCode		=> $g_networkCode,
		msisdnValidatorRefid	=> $g_msisdnValidatorRefid,
		timestampValidityRangeSeconds => $g_a3server_timestampValidityRangeSeconds,
		eviction_job_start_gmt	=> $g_a3server_eviction_job_start_gmt,
		ottCode			=> $g_a3server_ottCode,
		stage			=> post,
	}
}

class role_imps_base_new {

	class { imps:
		branch			=> $s_unity_branch,
		carrier			=> $s_carrier,
		yum_server1		=> $g_yum_server1,
		path			=> $s_imps_path,
		stage                   => post,
	}
}
class role_imps_memcache_new {

	class { 'imps::memcache':
#		branch			=> $s_unity_branch,
#		carrier			=> $s_carrier,
#		yum_server1		=> $g_yum_server1,
#		path			=> $s_imps_path,
#		heap			=> $g_imps_cache_heap,
		require                 => Class['imps'],
		stage                   => post,
	}
}

class role_imps_adm_new {

	class { 'imps::adm':
		branch			=> $s_unity_branch,
		carrier			=> $s_carrier,
		yum_server1		=> $g_yum_server1,
		path			=> $s_imps_path,
		heap			=> $g_imps_adm_heap,
		require                 => Class['imps'],
		stage                   => post,
	}
}

class role_imps_lb_new {

	class { 'imps::lb':
		branch			=> $s_unity_branch,
		carrier			=> $s_carrier,
		yum_server1		=> $g_yum_server1,
		path			=> $s_imps_path,
		heap			=> $g_imps_csplb_heap,
		require                 => Class['imps'],
		stage                   => post,
	}
}

class role_imps_fe_new {

	class { 'imps::fe':
		branch			=> $s_unity_branch,
		carrier			=> $s_carrier,
		yum_server1		=> $g_yum_server1,
		path			=> $s_imps_path,
		heap			=> $g_imps_fe_heap,
		require                 => Class['imps'],
		stage                   => post,
	}
}

class role_imps_app_new {

	class { mysql:
		stage                   => post,
	}
	class { 'imps::app':
		branch			=> $s_unity_branch,
		carrier			=> $s_carrier,
		yum_server1		=> $g_yum_server1,
		path			=> $s_imps_path,
		heap			=> $g_imps_be_heap,
		db_master		=> $g_db_cluster_master,
		db_slave		=> $g_db_cluster_slave,
		db_pwd			=> $g_db_cluster_pwd,
		sch_pwd			=> $g_schema_pwd_cluster,
		sch_sql_col_tbl		=> $g_imps_sch_sql_col_tbl,
		int_vip_cluster		=> $g_int_vip_cluster,
		multicastip		=> $g_imps_multicastip,
		multicastport		=> $g_imps_multicastport,
		require                 => Class['imps'],
		stage                   => post,
	}
}

class role_kan_new {

	class { kannel:
                unity_branch            => $s_unity_branch,
		port_monit		=> $g_port_monit,
		l_port_kannel_http	=> $g_l_port_kannel_http,
		v_port_kannel_ns	=> $g_v_port_kannel_ns,
		v_port_kannel_imps	=> $g_v_port_kannel_imps,
		v_port_kannel_subms	=> $g_v_port_kannel_subms,
		v_port_kannel_mu	=> $g_v_port_kannel_mu,
		v_port_kannel_em2sms	=> $g_v_port_kannel_em2sms,
		kannel_username_1	=> $g_kannel_username_1,
		kannel_password_1	=> $g_kannel_password_1,
		stage                   => post,
	}
}

class role_abimport_new {

        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { abimport:
                unity_branch            => $s_unity_branch,
                heap                    => $g_abimport_heap,
                offheap                 => $g_abimport_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		l_port_abimport_mo	=> $g_l_port_abimport_mo,
		v_port_imps_be          => $g_v_port_imps_be,
		int_vip_cluster		=> $g_int_vip_cluster,
		stage                   => post,
        }
}

class role_ccs_new {

}

class role_cdw_new {

	class { 'mysql::server':
		stage                   => post,
	}
}

class role_subms_new {

	class { 'mysql::server':
		stage                   => post,
	}
}

class role_mu_new {

	class { 'mysql::server':
		stage                   => post,
	}
}

class role_em2sms_new {

}

class role_romeo_new {

        class { 'mysql':
                stage                   => post,
        }
}

class role_cmp_new {

	class { mysql:
		stage                   => post,
	}
        class { cmp:
                unity_branch            => $s_unity_branch,
		yum_server1		=> $g_yum_server1,
		l_port_cmp		=> $g_l_port_cmp,
		v_port_cstore_admin	=> $g_v_port_cstore_admin,
		v_port_aaa_admin	=> $g_v_port_aaa_admin,
		int_vip_cluster		=> $g_int_vip_cluster,
		db_master		=> $g_db_cluster_master,
		db_slave		=> $g_db_cluster_slave,
		db_pwd			=> $g_db_cluster_pwd,
		sch_pwd			=> $g_schema_pwd_cluster,
		sch_sql_col_tbl		=> $g_cmp_sch_sql_col_tbl,
		stage                   => post,
        }
}

class role_li_new {

	class { mysql:
		stage                   => post,
	}
        class { li:
                unity_branch            => $s_unity_branch,
		yum_server1		=> $g_yum_server1,
		l_port_li		=> $g_l_port_li,
		int_vip_cluster		=> $g_int_vip_cluster,
		db_master		=> $g_db_cluster_master,
		db_slave		=> $g_db_cluster_slave,
		db_pwd			=> $g_db_cluster_pwd,
		sch_pwd			=> $g_schema_pwd_cluster,
		sch_sql_col_tbl		=> $g_li_sch_sql_col_tbl,
		stage                   => post,
        }
}

class role_cstore_new {

	class { mysql:
		stage                   => post,
	}
        class { platform:
                port_monit              => $g_port_monit,
                maxfileidle             => $g_maxfileidle,
                maxfilestale            => $g_maxfilestale,
                stage                   => post,
        }
        class { cstore:
                unity_branch            => $s_unity_branch,
                heap                    => $g_cstore_heap,
                offheap                 => $g_cstore_offheap,
                port_snmp               => $g_port_snmp1,
                snmp_receiver_ip        => $g_snmp_receiver_ip,
		v_port_cstore_admin	=> $g_v_port_cstore_admin,
		l_port_cstore_mo	=> $g_l_port_cstore_mo,
		v_port_aaa_admin	=> $g_v_port_aaa_admin,
		int_vip_cluster		=> $g_int_vip_cluster,
		db_master		=> $g_db_cluster_master,
		db_slave		=> $g_db_cluster_slave,
		db_pwd			=> $g_db_cluster_pwd,
		sch_pwd			=> $g_schema_pwd_cluster,
		sch_sql_col_tbl		=> $g_cstore_sch_sql_col_tbl,
		stage                   => post,
        }
}
