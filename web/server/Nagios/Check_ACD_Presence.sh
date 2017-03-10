#!/bin/sh

# This scripts give alerts when DB errors happened with applicaition

. /etc/rc.d/init.d/functions


DATA=""
TO_MAIL="deployment@panterranetworks.com,pbx_alerts@panterranetworks.com"
FROM_MAIL="ws_acd_presence_alert@panterranetworks.com"
SUBJECT="ACDEngine(.231) freeze  - NEED ATTENTION"
PATTERN_SEARCH="Some thing happened ping not came yet"
SEARCH_DIR="/opt/acdengine/log/"
LOGFILE=""

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

SENDMAIL() # This function call will helps in mailing the reqired data
{
        echo -e `date` > /home/wsadmin/MSG.DAT
        echo -e "\nWarning!\n Please verify ACD presence scenario?" >> /home/wsadmin/MSG.DAT

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
for entry in `ls -t $SEARCH_DIR`; do
    LOGFILE=$SEARCH_DIR$entry
    break
done

#curdate=`date +"%h %d %H:%M"`
curdate=`date --date="1 minute ago" +"%h %e %H:%M"`
echo "curentdate":$curdate
echo "logfile:"$LOGFILE
DATA=`grep "$curdate" $LOGFILE | grep -r "$PATTERN_SEARCH"`
        echo "output:"$DATA

if [ "$DATA" != "" ]
then
        echo $DATA
        SENDMAIL
fi

exit 1
