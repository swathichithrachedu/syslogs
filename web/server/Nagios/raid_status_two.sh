#/bin/bash
#Raid status

PRESENTSTATUS=`mpt-status -s | grep 'DEGRADED\|MISSING' | wc -l`

mpt-status > /home/wsadmin/operations/raidstatus.txt

DETAILREPORT=`cat /home/wsadmin/operations/raidstatus.txt`

if [ $PRESENTSTATUS -ne 0 ] ; then
/usr/sbin/sendmail -t -oi  <<EOF
From:raid_status@panterranetworks.com
To:waseem@panterranetworks.com
Subject: Critical!! Raid Status in 10.xx.xx.38

Hi Team,

Please check Raid Status in this server and take appropriate action.

Detail Report:-
$DETAILREPORT


Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi

