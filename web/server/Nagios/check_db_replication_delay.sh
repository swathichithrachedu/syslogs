#Replication delay 
#Waseem

CRITICAL="10"
SECONDS_BEHIND="" 
FLAG="/opt/MailSentFlag.txt"
DBHOST="10.20.48.106"
date=`date`
SUBJECT=""

SendMail(){
/usr/sbin/sendmail -t -oi  <<EOF
From:replicationdelay@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: $SUBJECT $DBHOST

Hi Team,
	$1
Time = $date


Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF
}

mysql -uwsadmin -h10.20.48.106 -pworksmart -e"show slave status \G;" > /home/wsadmin/waseem/Seconds_Behind_Master.txt
SECONDS_BEHIND=`cat /home/wsadmin/waseem/Seconds_Behind_Master.txt | grep Seconds_Behind_Master | awk '{print $2}'`

if  [ $SECONDS_BEHIND -ge $CRITICAL ]; then 
#Here I need to send mail
	if [ ! -f "$FLAG"  ]; then 
		SUBJECT="Replication delay in"
		MAIL_BODY="There is replication delay($SECONDS_BEHIND) in db $DBHOST, please verify once."
		SendMail "$MAIL_BODY"
		echo -e "Delay =  $SECONDS_BEHIND" > $FLAG;
		#echo -e "Delay observed , so sending mail "
   #else 
		#echo "Already sent an email , so No need to Send mail "
	fi
else
	if [ -f "$FLAG"  ]; then
  		SUBJECT="Replication delay resolved in "
		MAIL_BODY="Replication delay($SECONDS_BEHIND) resolved in db $DBHOST."
		#echo  "Replication delay is resolved , So i'm Sending Mail "
		SendMail "$MAIL_BODY"
		rm $FLAG;
	fi
fi


