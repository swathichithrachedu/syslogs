#Author Md Waseem
#International call cost Audit
#Developed Date:-09-07-2013
international_hourly=`mysql  -h10.20.48.76  -uwsadmin -pworksmart  ReportManager  -e "select * from ((select count(*)Before_1_day from int_hrcalls where intdate < date_sub(now(),interval 1 day))tab1,(select count(*)After_1_day from int_hrcalls)tab2 );"`
international_minute=`mysql  -h10.20.48.76  -uwsadmin -pworksmart  ReportManager  -e "select * from ((select count(*)Before_5_min from int_mincalls where ctime < date_sub(now(),interval 5  minute))tab1,(select count(*)After_5_min from int_mincalls)tab2 );"`


/usr/sbin/sendmail -t -oi  <<EOF
From:audit@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: International call cost scripts Audit.

International call cost : min monitoring

$international_minute

International call cost : Hourly monitoring

$international_hourly

If the count before is equal to after count then scripts stopped working.!!!

Else script's working fine as expected.


Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF
