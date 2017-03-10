#Ops DB Backup

DATE=`date +"%d-%m-%y"`
PASSWORD="";

cd /home/wsadmin/contacts_lnp_backups

stty -echo

echo -e "Enter Password \n";

read PASSWORD;
stty echo

if [ "$PASSWORD" = "" ]; then
    echo " Warning! 'PASSWORD parameter should not be empty'"
    echo " PLEASE GO THROUGH THE USER MANUAL"

else


echo -e "Generating DB Dumps, Please wait....................................\n"
mysqldump -p$PASSWORD -h10.20.48.103 -uwsadmin  contactsdb  -R > contactsdb-bkp-$DATE.sql
mysqldump -p$PASSWORD -h10.20.48.103 -uwsadmin  lnp  -R > lnp-bkp-$DATE.sql

echo -e "....................................................................\n"
echo -e "....................................................................\n"
echo -e "....................................................................\n"
echo -e "....................................................................\n"
echo -e "....................................................................\n"
echo -e "....................................................................\n"

filename=`ls -ltr /home/wsadmin/contacts_lnp_backups/ | tail -2 | awk '{print $9}'`
echo -e "DB Backup's for the date : $DATE has been generated"

/usr/sbin/sendmail -t -oi  <<EOF
From:autodbbackup@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: DB Backup : $DATE

Hi Team,
        DB Backup's for the date : $DATE has been generated.

Path:/home/wsadmin/contacts_lnp_backups/
File Names:-

$filename

Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF
fi
