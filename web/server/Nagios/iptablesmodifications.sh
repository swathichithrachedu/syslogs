#!/bin/bash
#Config file modification Author:Waseem

date=`date +%d-%m-%y-%R`
/sbin/service iptables status > /home/wsadmin/operations/iptables_status.txt

backupdir=/home/wsadmin/operations/iptables_backup
configdir=/home/wsadmin/operations

serveraddress=`echo "Server ip: 10.20.48.39"`
mainconffile=$1
standardfile=`/bin/ls -t $backupdir/$mainconffile* | /usr/bin/head -1`

changes=`/usr/bin/diff "$standardfile" $configdir/$mainconffile`


output=`/usr/bin/diff "$standardfile" $configdir/$mainconffile | /usr/bin/wc -l`

if [ $output -ne 0 ]

then /bin/cp $configdir/$mainconffile $backupdir/$mainconffile.bkf-"$date"

/usr/sbin/sendmail -t -oi  <<EOF
From:iptablesmonitor@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: IPTABLES Status Changed

Hi Team,
IPTABLES Status for the $serveraddress has been changed, please verify once.

$changes

Backup details:-
-------------------------
Path $backupdir
file name:$backupdir/$mainconffile.bkf-"date"

Thanks 
Operations Team

EOF

fi


