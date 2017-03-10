#!/bin/sh

# This scripts give alerts when DB errors happened with applicaition

. /etc/rc.d/init.d/functions


DATA=""
TO_MAIL="pbx_alerts@panterranetworks.com,dba@panterranetworks.com"
FROM_MAIL="ws_service_alert@panterranetworks.com"
SUBJECT="DATABASE errors at service Proxy Presence(.114) - NEED ATTENTION"
PATTERN_SEARCH="Query Execution Failed,DB error code"

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

SENDMAIL() # This function call will helps in mailing the reqired data
{
        echo -e `date` > /home/wsadmin/MSG.DAT
        echo -e "\nWarning!\n $DATA" >> /home/wsadmin/MSG.DAT

        body=`cat /home/wsadmin/MSG.DAT`
        {
            echo -e "To: $TO_MAIL"
            echo -e "From: $FROM_MAIL"
            echo -e "Subject: $SUBJECT"
            echo -e ""
            echo -e "$body"
            echo -e ""
        } | /usr/sbin/sendmail -oi -t

        rm -f MSG.DAT
}

#curdate=`date +"%h %d %H:%M"`
curdate=`date --date="1 minute ago" +"%h %e %H:%M"`
echo "curentdate":$curdate

DATA=`grep "$curdate" /var/log/messages | grep -r "$PATTERN_SEARCH" `

if [ "$DATA" != "" ]
then
	echo $DATA
        SENDMAIL
fi

exit 1

