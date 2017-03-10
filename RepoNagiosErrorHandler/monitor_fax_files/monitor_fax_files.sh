CUR_FILES=""

MAX_FILES=84    

################################################

##### FUNCTIONS DEFINITION startS FROM HERE#####

################################################

CUR_FILES=`ls -l /var/www/html/ | wc -l`

echo $CUR_FILES;

if [ $CUR_FILES -ge $MAX_FILES ];then

/usr/sbin/sendmail -t -oi  <<EOF
From:fax_monitor@panterranetworks.com
To:waseem@panterranetworks.com
Subject: Fax files monitor : (10.X.X.34)

Fax files in /var/www/html exceeds 84, please verify once.


Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi

