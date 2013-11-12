#!/bin/sh

#===================================================================
#
# This section will create the data folder where the DB will be
# located.
#
#===================================================================

		#-------------------------------------------------------------------
		# Creating the /data/mysql directory.
		#-------------------------------------------------------------------
		mkdir -p /data/mysql
			exitStatus=$?

			if [ ${exitStatus} -ne 0 ]; then
				exit 1
			fi
		chown -R mysql:mysql /data
			exitStatus=$?

			if [ ${exitStatus} -ne 0 ]; then
				exit 1
			fi


#===================================================================
#
# This section will install the MySQL db in the /data directory.
#
#===================================================================

		#-------------------------------------------------------------------
		# Creating the MySQL DB.
		#-------------------------------------------------------------------
		mysql_install_db --datadir=/data/mysql --user=mysql
		chown -R mysql:mysql /data/mysql
			exitStatus=$?

			if [ ${exitStatus} -ne 0 ]; then
				exit 1
			fi


#===================================================================
#
# This section will add the configuration for large page support.
#
#===================================================================

		#-------------------------------------------------------------------
		# Create the /etc/my.cnf file.
		#-------------------------------------------------------------------
		myCnf="/etc/my.cnf"

		if [ -s ${myCnf} ]; then
			cp -p ${myCnf} ${myCnf}.ORIG
			echo "" > ${myCnf}
		fi

		hostName=`hostname -s`

		serverIdToCheck=`echo ${hostName#${hostName%?}}`

		case ${serverIdToCheck} in
		1|2)
			serverId=${serverIdToCheck}
		;;
		*)
			echo -e "The value to be used for server-id and auto-increment-offset, ${serverIdToCheck}, is not 1 or 2, the script will stop execution."
			exit 1
		;;
		esac

		freeMemMB=`free -m | grep Mem | awk '{print $2}'`
		freeMemGB=`echo "scale=0; ${freeMemMB} / 1000" | bc`
		innodbBufferPoolSizeWithDecimal=`echo "scale=0; ${freeMemGB} * 0.75" | bc`
		innodbBufferPoolSize=`echo "${innodbBufferPoolSizeWithDecimal}" | cut -d '.' -f1`

		echo -e "# Configure port and socket for client" >> ${myCnf}
		echo -e "[client]" >> ${myCnf}
		echo -e "port = 3306" >> ${myCnf}
		echo -e "socket = /tmp/mysql.sock" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Configure large-pages" >> ${myCnf}
		echo -e "[mysqld]" >> ${myCnf}
		echo -e "large-pages  # added ${innodbBufferPoolSize}G" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Configure sql_mode as oracle" >> ${myCnf}
		echo -e "sql_mode = 'PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,NO_KEY_OPTIONS,NO_TABLE_OPTIONS,NO_FIELD_OPTIONS'" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Configure server port and socket" >> ${myCnf}
		echo -e "port = 3306" >> ${myCnf}
		echo -e "socket = /tmp/mysql.sock" >> ${myCnf}
		echo -e "datadir = /data/mysql" >> ${myCnf}
		echo -e "old_passwords = 0" >> ${myCnf}
		echo -e "lower_case_table_names = 1" >> ${myCnf}
		echo -e "innodb_file_per_table" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Configuration for replication" >> ${myCnf}
		echo -e "server-id = ${serverId}" >> ${myCnf}
		echo -e "auto-increment-increment = 2" >> ${myCnf}
		echo -e "auto-increment-offset = ${serverId}" >> ${myCnf}
		echo -e "relay-log = mysql-relay-bin" >> ${myCnf}
		echo -e "relay-log-index = mysql-relay-bin" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# log-bin should be enabled" >> ${myCnf}
		echo -e "back_log = 50" >> ${myCnf}
		echo -e "max_connections = 1000" >> ${myCnf}
		echo -e "max_connect_errors = 100" >> ${myCnf}
		echo -e "table_open_cache = 2048" >> ${myCnf}
		echo -e "max_allowed_packet = 128M" >> ${myCnf}
		echo -e "max_heap_table_size = 64M" >> ${myCnf}
		echo -e "thread_cache_size = 8" >> ${myCnf}
		echo -e "thread_concurrency = 8" >> ${myCnf}
		echo -e "query_cache_size = 64M" >> ${myCnf}
		echo -e "query_cache_limit = 2M" >> ${myCnf}
		echo -e "ft_min_word_len = 4" >> ${myCnf}
		echo -e "thread_stack = 192K" >> ${myCnf}
		echo -e "transaction_isolation = READ-COMMITTED" >> ${myCnf}
		echo -e "tmp_table_size = 32M" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Binlog related parameters" >> ${myCnf}
		echo -e "log-bin = mysql-bin" >> ${myCnf}
		echo -e "binlog_cache_size = 8M" >> ${myCnf}
		echo -e "binlog_format = mixed" >> ${myCnf}
		echo -e "#binlog-ignore-db = mysql" >> ${myCnf}
		echo -e "#binlog-ignore-db = test" >> ${myCnf}
		echo -e "expire-logs-days = 2" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Slow log related parameters" >> ${myCnf}
		echo -e "slow_query_log" >> ${myCnf}
		echo -e "slow_query_log_file = ${hostName}-slow.log" >> ${myCnf}
		echo -e "long_query_time = 5" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Different kind of buffer size" >> ${myCnf}
		echo -e "key_buffer_size = 20M" >> ${myCnf}
		echo -e "bulk_insert_buffer_size = 64M" >> ${myCnf}
		echo -e "myisam_sort_buffer_size = 64M" >> ${myCnf}
		echo -e "read_buffer_size = 8M" >> ${myCnf}
		echo -e "read_rnd_buffer_size = 32M" >> ${myCnf}
		echo -e "sort_buffer_size = 64M" >> ${myCnf}
		echo -e "join_buffer_size = 64M" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Myisam related parameters" >> ${myCnf}
		echo -e "myisam_max_sort_file_size = 10G" >> ${myCnf}
		echo -e "myisam_repair_threads = 1" >> ${myCnf}
		echo -e "myisam_recover" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "# Innodb related parameters" >> ${myCnf}
		echo -e "innodb_buffer_pool_size = ${innodbBufferPoolSize}G" >> ${myCnf}
		echo -e "innodb_additional_mem_pool_size = 16M" >> ${myCnf}
		echo -e "innodb_data_file_path = ibdata1:64M:autoextend" >> ${myCnf}
		echo -e "innodb_write_io_threads = 8" >> ${myCnf}
		echo -e "innodb_read_io_threads = 8" >> ${myCnf}
		echo -e "innodb_thread_concurrency = 16" >> ${myCnf}
		echo -e "innodb_flush_log_at_trx_commit = 0" >> ${myCnf}
		echo -e "innodb_log_buffer_size = 8M" >> ${myCnf}
		echo -e "innodb_log_file_size = 256M" >> ${myCnf}
		echo -e "innodb_log_files_in_group = 3" >> ${myCnf}
		echo -e "innodb_lock_wait_timeout = 120" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "[mysqldump]" >> ${myCnf}
		echo -e "quick" >> ${myCnf}
		echo -e "max_allowed_packet = 64M" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "[mysql]" >> ${myCnf}
		echo -e "no-auto-rehash" >> ${myCnf}
		echo -e "default-character-set = latin1" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "[myisamchk]" >> ${myCnf}
		echo -e "key_buffer_size = 64M" >> ${myCnf}
		echo -e "write_buffer = 4M" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "[mysqlhotcopy]" >> ${myCnf}
		echo -e "interactive-timeout" >> ${myCnf}
		echo -e "" >> ${myCnf}
		echo -e "[mysqld_safe]" >> ${myCnf}
		echo -e "open-files-limit = 8192" >> ${myCnf}
		echo -e "log_error" >> ${myCnf}
		echo -e "# The End" >> ${myCnf}

		chown mysql:mysql /etc/my.cnf
			exitStatus=$?

			if [ ${exitStatus} -ne 0 ]; then
				exit 1
			fi

		#-------------------------------------------------------------------
		# Update /etc/sysctl.conf
		#-------------------------------------------------------------------
		sysctlConf="/etc/sysctl.conf"
		cp -p ${sysctlConf} ${sysctlConf}.ORIG

		# Add the value to define the group for vm.hugetbl_shm_group.
		grep vm.hugetlb_shm_group ${sysctlConf} > /dev/null 2>&1
		exitStatus=$?

		if [ ${exitStatus} -ne 0 ]; then
			echo -e "vm.hugetlb_shm_group = `id -g mysql`" >> ${sysctlConf}
		else
			sed -i -e "s/vm.hugetlb_shm_group.*/vm.hugetlb_shm_group = `id -g mysql`/" ${sysctlConf} 
		fi

		# Define the value for vm.nr_hugepages.
		vmNrHugepages=`echo "scale=0; (${innodbBufferPoolSize} * 1024 * 1024 / 2048) + 260 + 1024" | bc`

		grep vm.nr_hugepages ${sysctlConf} > /dev/null 2>&1
		exitStatus=$?

		if [ ${exitStatus} -ne 0 ]; then
			echo -e "vm.nr_hugepages = ${vmNrHugepages}" >> ${sysctlConf}
		else
			sed -i -e "s/vm.nr_hugepages.*/vm.nr_hugepages = ${vmNrHugepages}/" ${sysctlConf} 
		fi
			
		# Adjust the value for shmmax.
		kernelShmmax=`echo "scale=0; (${innodbBufferPoolSize} + 2) * 1024 * 1024 * 1024" | bc`
		sed -i -e "s/kernel.shmmax = .*/kernel.shmmax = ${kernelShmmax}/" ${sysctlConf}

		# Adjust the value for shmall.
		pageSize=`getconf PAGE_SIZE`

		kernelShmall=`echo "scale=0; ${kernelShmmax} / ${pageSize}" | bc`
		sed -i -e "s/kernel.shmall = .*/kernel.shmall = ${kernelShmall}/" ${sysctlConf}

		#-------------------------------------------------------------------
		# Reload the /etc/sysctl.conf settings.
		#-------------------------------------------------------------------
		sysctl -p
		
		#-------------------------------------------------------------------
		# Update /etc/security/limits.conf
		#-------------------------------------------------------------------
		limitsConf="/etc/security/limits.conf"
		cp -p ${limitsConf} ${limitsConf}.ORIG

		# Add the root memlock value.
		grep "root.*memlock.*unlimited" ${limitsConf} > /dev/null 2>&1
		exitStatus=$?

		if [ ${exitStatus} -ne 0 ]; then
			sed -i -e "/# End of file/i\root  soft   memlock   unlimited\nroot  hard   memlock   unlimited" ${limitsConf}
		fi

		# Add the mysql memlock value.
		mysqlMemlock=`echo "scale=0; (${innodbBufferPoolSize} + 2 + 2) * 1024 * 1024" | bc`

		grep "mysql.*memlock.*" ${limitsConf} > /dev/null 2>&1
		exitStatus=$?

		if [ ${exitStatus} -ne 0 ]; then
			sed -i -e "/# End of file/i\mysql  soft   memlock ${mysqlMemlock}\nmysql  hard   memlock ${mysqlMemlock}" ${limitsConf}
		else
			sed -i -e "s/mysql.*soft.*memlock.*/mysql  soft   memlock ${mysqlMemlock}/" ${limitsConf}
			sed -i -e "s/mysql.*hard.*memlock.*/mysql  hard   memlock ${mysqlMemlock}/" ${limitsConf}
		fi
			
		#-------------------------------------------------------------------
		# Update /usr/bin/mysqld_safe
		#-------------------------------------------------------------------
		mysqldSafe="/usr/bin/mysqld_safe"
		cp -p ${mysqldSafe} ${mysqldSafe}.ORIG

		# Add the ulimit value.
		sed -i -e "/# executing mysqld_safe/aulimit -l unlimited" ${mysqldSafe}
