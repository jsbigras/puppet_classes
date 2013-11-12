#!/bin/sh

#===================================================================
#
# This section will set the root password locally on the server.
#
#===================================================================

#-------------------------------------------------------------------"
# Creating the mysql root user."
#-------------------------------------------------------------------"
mysql -uroot -e "create user 'root'@'%' identified by 'synchronica';"
mysql -uroot -e "grant all privileges on *.* to 'root'@'%' with grant option;"
mysql -uroot -e "grant proxy on ''@'' to 'root'@'%' with grant option;"


#===================================================================
#
# This section will drop all the unwanted users in the DB.
# This secion will also create the root@'127.0.0.1'.
#
#===================================================================

#-------------------------------------------------------------------"
# Remove the unwanted users in the DB."
#-------------------------------------------------------------------"
mysql -uroot -e "drop user ''@'localhost';"
mysql -uroot -e "drop user 'root'@'localhost';"
mysql -uroot -psynchronica -e "drop user ''@'`hostname`';"
mysql -uroot -psynchronica -e "drop user 'root'@'::1';"
mysql -uroot -psynchronica -e "drop user 'root'@'127.0.0.1';"
mysql -uroot -psynchronica -e "drop user 'root'@'`hostname`';"

#-------------------------------------------------------------------"
# Creating the mysql root@'127.0.0.1' user."
#-------------------------------------------------------------------"
mysql -uroot -psynchronica -e "create user 'root'@'127.0.0.1' identified by 'synchronica';"
mysql -uroot -psynchronica -e "grant all privileges on *.* to 'root'@'127.0.0.1' with grant option;"
mysql -uroot -psynchronica -e "grant proxy on ''@'' to 'root'@'127.0.0.1' with grant option;"

#-------------------------------------------------------------------"
# Create the nagios user for monitoring."
#-------------------------------------------------------------------"
mysql -uroot -psynchronica -e "create user 'nagios'@'%' identified by 'nagios';"
mysql -uroot -psynchronica -e "grant super, replication slave on *.* to 'nagios'@'%';"


# #===================================================================
# #
# # This section will setup the master-salve replication. (Only when 2 DB servers)
# #
# #===================================================================

# #-------------------------------------------------------------------"
# # Create the replication user on the fisrt DB server (master)"
# # Execute the following from the command line."
# #-------------------------------------------------------------------"
# otherDbIp=\`grep db /etc/hosts | grep \\\`hostname -s | cut -d '-' -f1\\\` | grep -v \\\`hostname\\\` | awk '{print \$1}'\`
# mysql -uroot -psynchronica -e "create user 'replslave'@'${otherDbIp}' identified by 'replslave';"
# mysql -uroot -psynchronica -e "grant replication slave on *.* to 'replslave'@'${otherDbIp}';"

		# showMasterStatus=\`mysql -uroot -psynchronica -s -e "show master status;" | tail -1\`
		# masterLogFile=\`echo \${showMasterStatus} | awk '{print \$1}'\`
		# masterLogPosition=\`echo \${showMasterStatus} | awk '{print \$2}'\`
# #-------------------------------------------------------------------"
# # Change  replication configuration on the second DB server (slave)"
# # Execute the following from the command line."
# #-------------------------------------------------------------------"
		# otherDbIp=\`grep db /etc/hosts | grep \\\`hostname -s | cut -d '-' -f1\\\` | grep -v \\\`hostname\\\` | awk '{print \$1}'\`

		# showMasterStatus="value from the Master"
		# masterLogFile="value from the Master"
		# masterLogPosition="value from the Master"

# mysql -uroot -psynchronica -e "stop slave;"
# mysql -uroot -psynchronica -e "CHANGE MASTER TO MASTER_HOST='\${otherDbIp}', MASTER_USER='replslave', MASTER_PASSWORD='replslave', MASTER_LOG_FILE='\${masterLogFile}', MASTER_LOG_POS=\${masterLogPosition};"
# mysql -uroot -psynchronica -e "start slave;"

# mysql -uroot -psynchronica -e "show slave status \G;"

exit 0