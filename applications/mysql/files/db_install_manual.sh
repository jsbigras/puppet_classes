#!/bin/sh

#===================================================================
#
# This section will set the root password locally on the server. (on each DB server)
#
#===================================================================

		echo -e "#-------------------------------------------------------------------"
		echo -e "# Creating the mysql root user."
		echo -e "# Execute the following from the command line."
		echo -e "#-------------------------------------------------------------------"
		echo -e "/usr/bin/mysqladmin -u root password 'synchronica'"
		echo -e ""

		echo -e "mysql -uroot -psynchronica -e \"create user 'root'@'%' identified by 'synchronica';\""
		echo -e "mysql -uroot -psynchronica -e \"grant all privileges on *.* to 'root'@'%' with grant option;\""
		echo -e "mysql -uroot -psynchronica -e \"grant proxy on ''@'' to 'root'@'%' with grant option;\""
		echo -e ""


#===================================================================
#
# This section will drop all the unwanted users in the DB. (on each DB server)
# This secion will also create the root@'127.0.0.1'.
#
#===================================================================

		echo -e "#-------------------------------------------------------------------"
		echo -e "# Remove the unwanted users in the DB."
		echo -e "# Execute the following from the command line."
		echo -e "#-------------------------------------------------------------------"
		echo -e "mysql -uroot -psynchronica -e \"drop user ''@'localhost';\""
		echo -e "mysql -uroot -psynchronica -e \"drop user ''@'`hostname`';\""
		echo -e "mysql -uroot -psynchronica -e \"drop user 'root'@'::1';\""
		echo -e "mysql -uroot -psynchronica -e \"drop user 'root'@'127.0.0.1';\""
		echo -e "mysql -uroot -psynchronica -e \"drop user 'root'@'`hostname`';\""
		echo -e ""

		echo -e "#-------------------------------------------------------------------"
		echo -e "# Creating the mysql root@'127.0.0.1' user."
		echo -e "# Execute the following from the command line."
		echo -e "#-------------------------------------------------------------------"
		echo -e "mysql -uroot -psynchronica -e \"create user 'root'@'127.0.0.1' identified by 'synchronica';\""
		echo -e "mysql -uroot -psynchronica -e \"grant all privileges on *.* to 'root'@'127.0.0.1' with grant option;\""
		echo -e "mysql -uroot -psynchronica -e \"grant proxy on ''@'' to 'root'@'127.0.0.1' with grant option;\""
		echo -e ""


#===================================================================
#
# This section will setup the master-master replication. (Only when 2 DB servers)
#
#===================================================================

		echo -e "#-------------------------------------------------------------------"
		echo -e "# Create the replication user."
		echo -e "# Execute the following from the command line."
		echo -e "#-------------------------------------------------------------------"
		echo -e "mysql -uroot -psynchronica -e \"create user 'replslave'@'%' identified by 'replslave';\""
		echo -e "mysql -uroot -psynchronica -e \"grant replication slave on *.* to 'replslave'@'%';\""
		echo -e ""

		echo -e "#-------------------------------------------------------------------"
		echo -e "# Change Master Host."
		echo -e "# Execute the following from the command line."
		echo -e "#-------------------------------------------------------------------"
		echo -e "otherDbIp=\`grep db /etc/hosts | grep \\\`hostname -s | cut -d '-' -f1\\\` | grep -v \\\`hostname\\\` | awk '{print \$1}'\`"
		echo -e ""

		echo -e "showMasterStatus=\`mysql -uroot -psynchronica -s -e \"show master status;\" | tail -1\`"
		echo -e "masterLogFile=\`echo \${showMasterStatus} | awk '{print \$1}'\`"
		echo -e "masterLogPosition=\`echo \${showMasterStatus} | awk '{print \$2}'\`"
		echo -e ""

		echo -e "mysql -uroot -psynchronica -e \"stop slave;\""
		echo -e ""
		echo -e "mysql -uroot -psynchronica -e \"CHANGE MASTER TO MASTER_HOST='\${otherDbIp}', MASTER_USER='replslave', MASTER_PASSWORD='replslave', MASTER_LOG_FILE='\${masterLogFile}', MASTER_LOG_POS=\${masterLogPosition};\""
		echo -e ""
		echo -e "mysql -uroot -psynchronica -e \"start slave;\""
		echo -e ""

		echo -e "mysql -uroot -psynchronica -e \"show slave status \G;\""
		echo -e ""


#===================================================================
#
# This section will setup the user to be used for Nagios monitoring. (on each DB server)
#
#===================================================================

		echo -e "#-------------------------------------------------------------------"
		echo -e "# Create the nagios user for monitoring."
		echo -e "# Execute the following from the command line."
		echo -e "#-------------------------------------------------------------------"
		echo -e "mysql -uroot -psynchronica -e \"create user 'nagios'@'%' identified by 'nagios';\""
		echo -e "mysql -uroot -psynchronica -e \"grant super, replication slave on *.* to 'nagios'@'%';\""
		echo -e ""


exit 0