CUR_LOG_FILE_SIZE=""
MAX_LOG_FILE_SIZE=1073741824    #MAX log file size is 1GB(1024*1024*1024=1073741824 Bytes)

TO_MAIL="deployment@panterranetworks.com"
FROM_MAIL="ws_presencelog_alert@panterranetworks.com"
SUBJECT_LOG="Current log file size in presence service exceeds max limit .114 - NEED ATTENTION"

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

SENDMAIL_LOG_ALERT() # This function call will helps in mailing the reqired data
{
        {
                echo -e "To: $TO_MAIL"
                echo -e "From: $FROM_MAIL"
                echo -e "Subject: $SUBJECT_LOG"
                echo -e ""
                echo -e "Presence Log file exceeds max limit of 1GB , current file size:$FILE_SIZE GB time $curdate"
                echo -e ""
        } | /usr/sbin/sendmail -oi -t
}

CREATE_FILE_LOG()
{
        `touch /tmp/MSG_LOG.DAT`
}

DELETE_FILE_LOG()
{
        `rm -f /tmp/MSG_LOG.DAT`
}

CHECK_FILE_LOG=`ls -l /tmp/MSG_LOG.DAT | wc -l`

curdate=`date --date="1 minute ago" +"%h %e %H:%M:%S"`

CUR_LOG_FILE_SIZE=`du -b /var/log/messages | cut -f1`

FILE_SIZE=$((CUR_LOG_FILE_SIZE/MAX_LOG_FILE_SIZE))
echo "File size is $FILE_SIZE GB"
if [ "$FILE_SIZE" -ge "1" ] && [ $CHECK_FILE_LOG -eq "0" ];then
        echo "Current log file size is : $FILE_SIZE"
        SENDMAIL_LOG_ALERT
        CREATE_FILE_LOG
        elif [ $CHECK_FILE_LOG -eq "1" ] && [ "$FILE_SIZE" -ge "1" ];then
                echo "Still logger is more than 1GB , need to verify asap"
        elif [ $CHECK_FILE_LOG -eq "1" ] && [ "$FILE_SIZE" -eq "0" ];then
                DELETE_FILE_LOG
fi

