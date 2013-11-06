#!/bin/sh
mypid=`ps -C monitorCPU.sh --no-headers -o pid= | awk 'BEGIN{i=0}{if(i==0){printf"%s\n",$1;i=1}}'`

if [ $mypid ]
then
	if [ -r "/etc/snmp/cpustats.txt" ]
	then
		myresult=`cat /etc/snmp/cpustats.txt | cut -d " " -f$1`
		exit $myresult
	else
		exit 255
	fi
else
	exit 255
fi


