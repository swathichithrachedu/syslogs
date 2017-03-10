# Auto Disable fax monitoring(cron)

DATA=""

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

DATA=`/usr/bin/crontab -l | grep -w "sendmonitoringfax.sh" | awk '{ print $1}'`


if [ "$DATA" = "*/10" ];then

crontab -l | sed '/^[^#].*sendmonitoringfax.sh/s/^/#/' | crontab -

/usr/sbin/sendmail -t -oi  <<EOF
From:faxcron@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: Fax monitoring Disabled

Hi Team,
        Fax Monitoring has been Disabled.

Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi
