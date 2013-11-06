#!/bin/sh
# loop forever
while [ 1 ]
do
	myresult=$(vmstat 1 3 | awk 'BEGIN{i=0;ID=-1;US=-1;SY=-1;}function fnc(ln,pos,str){if (ln!=0){if(pos!=-1){if(ln==4){printf"%03d ",$pos}}for(y=1;y<=NF;y++){if ($y==str){pos=y;}}}return pos;}{SY=fnc(i,SY,"sy");US=fnc(i,US,"us");ID=fnc(i,ID,"id");i++;}END{printf"\n"}')
	exitcode=$?
	if [ $exitcode -ne 0 ] ; then		
		echo 255 255 255 > "/etc/snmp/cpustats.txt"
		break;
	else	
		echo $myresult > "/etc/snmp/cpustats.txt"
	fi				

    sleep 30
done
