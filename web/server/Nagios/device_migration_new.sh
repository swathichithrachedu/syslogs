#!/bin/sh
LIVEDBHOST="10.20.48.100"
WAREHOUSEDBHOST="10.20.48.104"
DBUSER="wsadmin"
DBPSWD="worksmart"
DBNAME1="livepbx"
DBNAME2="warehousepbx"

mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "insert ignore into devsys(id,ms,mkey,creationtime,modifiedtime)  select '',md5checksum,md5key,now(),now() from(select md5checksum,md5key from authenticated_users union select md5checksum,md5key from authentication_pending_users union select md5checksum,md5key from blocked_users )tab ;"

mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "insert into devsys_mh(sys_id,ms) select id,ms from devsys;"

mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "insert into devusers_a  select '',(select id from devsys d where ms=md5checksum and mkey=md5key  ),userid,usertype,creationtime,modifiedtime,sysname from authenticated_users a ;"

mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "insert into pending_sys select'',(select id from devsys d where ms=md5checksum and mkey=md5key ),userid,usertype,creationtime,modifiedtime,scode,triedcount,urlkey,sysname from authentication_pending_users a ;"


mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "insert into devusers_b  select '',(select id from devsys d where ms=md5checksum and mkey=md5key  ),userid,usertype,creationtime,modifiedtime,sysname from blocked_users a;"


mysqldump -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 devsys devsys_mh devusers_a pending_sys devusers_b > /home/wsadmin/securitytables.sql
mysql -h$WAREHOUSEDBHOST -u$DBUSER -p$DBPSWD $DBNAME2 < /home/wsadmin/securitytables.sql
mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "truncate table devsys"
mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "truncate table devusers_a"
mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "truncate table devusers_b"
mysql -h$LIVEDBHOST -u$DBUSER -p$DBPSWD $DBNAME1 -e "truncate table pending_sys"



