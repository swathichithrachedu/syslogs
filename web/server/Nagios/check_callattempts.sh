mysql  -uwsadmin -pworksmart lcrdb -e "select inittime, called_from, called_to, duration from cdr where call_type = 3 and inittime > date_sub(now(), interval 30 minute);" > /home/wsadmin/act_calls.dat

var1=`cat /home/wsadmin/act_calls.dat | wc -l`

if [ $var1 -gt 20 ];then

var2=`cat /home/wsadmin/act_calls.dat`

/usr/sbin/sendmail -t -oi  <<EOF
From:callmonitor@panterranetworks.com
To:operations@panterranetworks.com
Subject: International calls - Too many calls/attempts.

International call attempts in the last 30 minutes exceeded 20. Please verify!
The call details are:

$var2

Thanks,

Operations Team
PanTerra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi
