# Auto Enable fax monitoring(cron)

DATA=""

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

DATA=`/usr/bin/crontab -l | grep -w "sendmonitoringfax.sh" | awk '{ print $1}'`


if [ "$DATA" = "#*/10" ];then

crontab -l | sed '/^#.*sendmonitoringfax.sh/s/^#//' | crontab -

/usr/sbin/sendmail -t -oi  <<EOF
From:faxcron@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: Fax Monitoring Enabled

Hi Team,
        Fax monitoring has been enabled,we will be getting fax alerts soon.

Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi

