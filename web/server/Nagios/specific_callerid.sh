#######################################################################################
#            Specific Callerid  Script
#
#
#
#
#       Author:Md Waseem  (Operation's Team)
###############################################################################

mysql  -uwsadmin -h10.20.48.230 -pworksmart -e"select called_from, called_to, count(*) cn, round(sum(duration)/60) from lcrdb.cdr where status = 200 AND inittime > date_sub(now(), interval 1 hour) group by called_from, called_to having cn > 1  order by cn desc;" > /home/wsadmin/waseem/scripts/callerid.txt

var1=`cat /home/wsadmin/waseem/scripts/callerid.txt  | wc -l`

Specific_Callerid=`cat /home/wsadmin/waseem/scripts/callerid.txt`



if [ $var1 -gt 1 ];then

echo " iam entered in to if , sending mail "

/usr/sbin/sendmail -t -oi  <<EOF
From:callerid_monitor@panterranetworks.com
To:waseem@panterranetworks.com
Subject: Alert : The Lcr call Attempts for last hour exceeds 25.

Hi Team,
       Please login to Lcr call Attempt Tool for further details

http://monitoring.wspbx.com:9000/reports/lcr_call_attempts.php
        



Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558





EOF

fi
