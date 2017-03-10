DATA=""
TO_MAIL="indiaops@panterranetworks.com"
FROM_MAIL="ws_vqmanager@panterranetworks.com"

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

SENDMAIL() # This function call will helps in mailing the reqired data
{
        echo -e `date` > /home/wsadmin/MSG.DAT
        echo -e "\nWarning! $DATA" >> /home/wsadmin/MSG.DAT

        body=`cat /home/wsadmin/MSG.DAT`
        {
            echo -e "To: $TO_MAIL"
            echo -e "From: $FROM_MAIL"
            echo -e "Subject: VQ_Manager Freeze - NEED ATTENTION"
            echo -e ""
            echo -e "$body"
            echo -e ""
        } | /usr/sbin/sendmail -oi -t

        rm -f MSG.DAT
}


DATA=`tail -n 50 /root/VQManager6.3/VQManager/logs/vqmlog0.txt | grep -r "There is no VoIP traffic coming to VQManager server" | cut -d'|' -f 6`

if [ "$DATA" != "" ]
then
        SENDMAIL
fi

exit 1
