#####Fire Wall Monitor#####################
#####Author Md Waseem#####################

TO_MAIL="waseem@panterranetworks.com"

FROM_MAIL="wsfirewall@panterranetworks.com"

SERVER_IP="10.20.48.76"

SENDMAIL_FLAG="0";

SENDMAIL_LOG_ALERT()
{

       {

                echo -e "To: $TO_MAIL"

                echo -e "From: $FROM_MAIL"

                echo -e "Subject: Critical!! Fire wall stopped"

                 echo -e "\n"

                echo -e "Please Verify Firewall \n"

                echo -e "Server :$SERVER_IP \n"

                echo -e "Thanks & Regards"

                echo -e "Operations Team"

                
} | /usr/sbin/sendmail -oi -t

}

/sbin/service iptables status >/dev/null 2>&1
if [ $? = 0 ]; then
    echo "Fire wall running"
else
    echo "Critical !! Firewall stopped"
    SENDMAIL_FLAG=1;
fi


if [ "$SENDMAIL_FLAG" -eq "1" ]; then

        SENDMAIL_LOG_ALERT

fi
        
