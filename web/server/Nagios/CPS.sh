#!/bin/bash
#Calls Per Second
#Author Waseem
#02-01-2014
FILENAME=`ls /opt/messages* -ltr | tail -1 | awk '{print $9}'`
TodayDate=`date +%e`;
MAILDATE=`date +%Y-%m-%d -d "-1 day"`
if [ "$TodayDate" -lt "10" ];then

#ICP
/bin/grep "parse_ws_uri][uri]" $FILENAME | cut -d ' ' -f 1,2,3,4,7 | cut -d'=' -f 1 > /home/wsadmin/operations/ICP_23.txt
#UMSLB
/bin/grep "parse_ws_uri][uri]" $FILENAME | cut -d ' ' -f 1,2,3,4,7 | cut -d'=' -f 1 > /home/wsadmin/operations/UMSLB_23.txt

else 
#ICP
/bin/grep "parse_ws_uri][uri]" $FILENAME | cut -d ' ' -f 1,2,3,6 | cut -d'=' -f 1 > /home/wsadmin/operations/ICP_23.txt

#UMSLB
/bin/grep "parse_ws_uri][uri]" $FILENAME | cut -d ' ' -f 1,2,3,6 | cut -d'=' -f 1 > /home/wsadmin/operations/UMSLB_23.txt

fi 

#DataBase Function: Inserting Data in to reportingdb(.76)




mysql -uwsadmin -h10.20.48.76 -pworksmart -e"select call_time,count(*) cn from reportingdb.msicp_23_cps group by call_time order by cn desc limit 10;" > /home/wsadmin/operations/output_icp.txt

output=`cat /home/wsadmin/operations/output_icp.txt`

mysql -uwsadmin -h10.20.48.76 -pworksmart -e"select call_time,count(*) cn from reportingdb.UMS_cps_23 group by call_time order by cn desc limit 10;" > /home/wsadmin/operations/output_ums.txt

output1=`cat /home/wsadmin/operations/output_ums.txt`

#Send Mail Function Strats from Here:-

/usr/sbin/sendmail -t -oi  <<EOF
From: cps@panterranetworks.com
To: waseem@panterranetworks.com
Subject: CPS:- Server 10.xx.xx.23 Date : $MAILDATE

Hi Team,

Please find the CPS details below:

        UMSLB
-----------------------------------------

$output1


         ICP's
----------------------------------------------
$output


Thanks
Operations Team



