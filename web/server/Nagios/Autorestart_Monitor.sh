#/bin/bash
#Author Md Waseem



var1=""
var2="#*"

#/usr/bin/crontab -l | head -1 > /home/wsadmin/waseem/scripts/test.txt

cd /home/wsadmin/waseem/scripts/

var1=`/bin/cat test | awk '{ print $1}'`

if [ "$var1" = "$var2" ];then

/usr/sbin/sendmail -t -oi  <<EOF
From:auto_restart_monitor@panterranetworks.com
To:waseem@panterranetworks.com
Subject: Auto Restart disabled : UMS (10.X.X.39)

Auto restart disabled for UMS(10.X.X.39), make sure to re-enable.

Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi
