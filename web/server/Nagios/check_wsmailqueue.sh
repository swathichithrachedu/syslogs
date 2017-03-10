#/bin/bash
#Author Md Waseem
#mqueue monitoring 
#DATE:-11/06/2013


################################################

##### FUNCTIONS DEFINITION startS FROM HERE#####

################################################

COUNT_mqueue=`ls /var/spool/mqueue | wc -l`
COUNT_clientmqueue=`ls /var/spool/clientmqueue | wc -l`

/usr/sbin/sendmail -t -oi  <<EOF
From:mqueue_monitor@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: Mqueue Monitoring

Hi Team,

Please find the stuck Queue details for 10.XX.XX.128

/var/spool/mqueue        =  $COUNT_mqueue
/var/spool/clientmqueue  =  $COUNT_clientmqueue



Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF






