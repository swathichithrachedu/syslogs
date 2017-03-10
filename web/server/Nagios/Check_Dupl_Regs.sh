#!/bin/sh

# This scripts give alerts when duplicate registrations exceeds given threshold value...By Prashant 10/Jan/2014

. /etc/rc.d/init.d/functions

THRESHOLD=10
DBUSER="wsadmin"
DBSCHEMA="livepbx"
DBPSWD="worksmart"
DBHOST="10.20.48.106"
SUBJECT="Registration limit is exceeded!"
FROM_MAIL="ws_service_alert@panterranetworks.com"
LOG="/home/wsadmin/DupRegistrations/Dupl_Regs_Script_log.txt"
TO_MAIL="dba@panterranetworks.com deployment@panterranetworks.com"
DUPL_RECORDS_DETAILS="/home/wsadmin/DupRegistrations/Dupl_Regs_Details.txt"

################################################
##### FUNCTIONS DEFINITION STARTS FROM HERE#####
################################################

SENDMAIL() # This function call will helps in mailing the reqired data
{
        body=`cat $DUPL_RECORDS_DETAILS`
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


rm -f $DUPL_RECORDS_DETAILS

#Check in DB
	mysql -p"$DBPSWD" -h"$DBHOST" -u"$DBUSER" "$DBSCHEMA" -e "SELECT COUNT(*) Reg_Count,username,SUBSTRING_INDEX(contact,':',2) cntct,user_agent,registrar,local_registrar,max(last_modified) FROM location GROUP BY username,cntct,user_agent,registrar,local_registrar HAVING Reg_Count > $THRESHOLD \G" > $DUPL_RECORDS_DETAILS


#If duplicates found then send mail
if [ -s "$DUPL_RECORDS_DETAILS"  ]
then
	echo -e "Hi,\n\tFollowing users have more than $THRESHOLD registraitons. Please verify that if any stuck registrations...\n\n `cat $DUPL_RECORDS_DETAILS`" > $DUPL_RECORDS_DETAILS
	echo -e "Sending mail..."
	echo -e "Duplicate Registrations found at `date +%F' '%X` ! Sending mail..." >> $LOG
	SENDMAIL

#If nothing is found, do nothing
else
	echo -e "No problem found..."
	echo -e "No Duplicate Registrations at `date +%F' '%X` !" >> $LOG
fi
exit 1
