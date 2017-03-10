#!/bin/sh
HOST=38.113.118.21
USER=wsadmin
PASSWD=m@gicn00dl3s

#cd /opt

DATECHECK_OLD=`cat /home/wsadmin/operations/datecheck_old.txt | awk '{print $7}'`

FILE_NEW=`ls /opt/messages_wsinregistrar_wsobproxy* -ltr | tail -1 > /home/wsadmin/operations/datecheck_new.txt`


DATECHECK_NEW=`cat /home/wsadmin/operations/datecheck_new.txt | awk '{print $7}'`

FILENAME=`ls /opt/messages_wsinregistrar_wsobproxy* -ltr | tail -1 | awk '{print $9}'`

FILE_OLD=`ls /opt/messages_wsinregistrar_wsobproxy* -ltr | tail -1 > /home/wsadmin/operations/datecheck_old.txt`


if [[ "$DATECHECK_OLD" -ne "$DATECHECK_NEW" ]] ; then

lftp<<END_SCRIPT
open sftp://$HOST -p2342
user $USER $PASSWD
cd /opt/loggers/registars/
put $FILENAME
bye
END_SCRIPT

fi
