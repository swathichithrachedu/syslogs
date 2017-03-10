#Config file modification Author:Waseem

date=`date +%d-%m-%y-%R`

backupdir=/home/wsadmin/waseem/scripts/nfs/
configdir=/home/wsadmin/operations/

serveraddress=`echo "Server ip: 10.20.48.76"`
echo $serveraddress
mainconffile=$1
echo $mainconffile
standardfile=`/bin/ls -t $backupdir/$mainconffile* | /usr/bin/head -1`

echo $standardfile
changes=`/usr/bin/diff "$standardfile" $configdir/$mainconffile`

echo $changes

output=`/usr/bin/diff "$standardfile" $configdir/$mainconffile | /usr/bin/wc -l`
echo $output

if [ $output -ne 0 ]

then /bin/cp $configdir/$mainconffile $backupdir/$mainconffile.bkf-"$date"

/usr/sbin/sendmail -t -oi  <<EOF
From:nfsmonitor@panterranetworks.com
To:waseem@panterranetworks.com
Subject: Config File changed $configdir/$mainconffile

Please find the details below :-

$serveraddress

$changes

Backup details:-
-------------------------
Path $backupdir
file name:$backupdir/$mainconffile.bkf-"date"

Thanks 
Operations Team

EOF

fi


