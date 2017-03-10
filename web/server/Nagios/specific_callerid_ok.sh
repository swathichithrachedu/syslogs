#######################################################################################
#            Specific Callerid  Script
#
#
#
#
#       Author:Md Waseem  (Operation's Team)
###############################################################################

mysql -uwsadmin -h10.20.48.230 -pworksmart -e"select called_from, count(*) cn from lcrdb.cdr where status = 200 AND inittime > date_sub(now(), interval 1 hour)  group by called_from having cn > 10 order by cn desc limit 50;" > /home/wsadmin/waseem/scripts/callerid.txt

var1=`cat callerid.txt | wc -l`

Specific_Callerid=`cat /home/wsadmin/waseem/scripts/callerid.txt`

#echo $var1


if [ $var1 -gt 1 ];then

#echo " iam entered in to if , sending mail "

/usr/sbin/sendmail -t -oi  <<EOF
From:callerid_monitor@panterranetworks.com
To:waseem@panterranetworks.com
Subject: Alert : Number of calls from a specific callerid exceeded 10 

Hi Team,
        Please verify Caller ID,

Assign specific callerid limit = 51
Present specific callerid count = $var1

$Specific_Callerid

Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558





EOF

fi
