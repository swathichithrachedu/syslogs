#!/bin/sh
DBHOST="10.20.48.104"
DBUSER="wsadmin"
DBPSWD="worksmart"
DBNAME="archive_warehousepbx"
#we need to drop indexes from the tables agentinfodesc backup_monitoring_com queueinfodesc special in production
rm -f tblist

 mysql -p$DBPSWD -u$DBUSER -h$DBHOST -e "select table_name from information_schema.tables where table_schema = '$DBNAME' " > /home/wsadmin/tblist
exec < /home/wsadmin/tblist
var=0
while  read data
do
        var=`expr $var + 1`;
        if [ $var -gt 1 ]; then
                echo -e $data;
	mysql -p$DBPSWD -u$DBUSER -h$DBHOST $DBNAME -e "alter table $data engine='archive'";

	echo -e "Engine type of $data table changed to archive";
        fi

done
