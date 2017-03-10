#!/bin/sh

# The main objective of this script is to restart the services when there process(es) are inactive 
# The services will be restarted when the active number of process(es) are less than required number of precess(es)
# If any dependences services are present then there will be restarted along with the main service if there are inactive

. /etc/rc.d/init.d/functions

HOST="10.20.8.121"
SLEEP_TIME="4"
MAX_TIME="44"
NETWORK="PRODUCTION"
FLAG=0
SPL_CASE=0
mail_count=0

CHATSERVER_EXE="/home/wsadmin/chatserver/bin/chatserver"
CHATSERVER_CONF="/home/wsadmin/chatserver/conf/chatserver.xml"
prog=chatserver
RETVAL=0

REQ_COUNT=1

#TO_MAIL="sundeep@panterranetworks.com"
TO_MAIL="gopinath@panterranetworks.com,deployment@panterranetworks.com"
#TO_MAIL="pbxdev@panterranetworks.com,qa@panterranetworks.com"
FROM_MAIL="ws_service_alert@panterranetworks.com"

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
################################################

start() {
        echo -n $"Starting $prog: "
		if [ -e $CHATSERVER_CONF ];then
        	daemon $CHATSERVER_EXE $CHATSERVER_CONF
		else
			echo -n " UNABLE TO START SERVER --> CONFIGURATION FILE MISSING "
		fi
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && touch /var/lock/subsys/chatserver && touch /var/lock/subsys/chatserver /var/run/chatserver.pid
        return $RETVAL
}

stop() {
    echo -n $"Stopping $prog: "
    echo $prog
    killproc $prog
	/usr/bin/find  /opt/chatserver/html -mtime +2 -exec rm {} \;
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f /var/lock/subsys/chatserver /var/run/chatserver.pid /var/lock/subsys/chatserver /var/run/chatserver.pid
}

SENDMAIL() # This function call will helps in mailing the reqired data
{
       if [ $SPL_CASE -eq 1 ];then
		        subject="$2 Service has been restarted in $NETWORK Network <$HOST> after recovery"
	   elif [ $FLAG -eq 1 ];then
                subject="Unable to start $2 service, please verify it in $NETWORK Network <$HOST>"
                echo -e "\n\nWARNING: UNABLE TO START $2 SERVICE. PLEASE VERIFY IT IN $NETWORK NETWORK <$HOST>\n\n" > MSG
        else 
                subject="$2 has been restarted in $NETWORK Network <$HOST>"
        fi
        echo -e "$2 Service has been restarted due to following reasons\n\nThe number of active process is $1 \n\nRequired number active process is $3" >> MSG
        echo -e "\n\n Below are the list of processes before restarting the  $2 services\n\n" >> MSG
        echo -e "ps -eaf | grep $2\n" >> MSG
		while read line
        do
                echo "$line" >> MSG
        done < chat_msg

	    body=`cat MSG`
	    {
	        echo -e "To: $TO_MAIL"
            echo -e "From: $FROM_MAIL"
	        echo -e "Subject: $subject"
            echo -e ""
            echo -e "$body"
	        echo -e ""
	    } | /usr/sbin/sendmail -oi -t

        rm -f MSG chat_msg
}

# The following function is called when a particular service is inactive or required number of process(es) are not running
# Send a mail to the adminstrator about the restarting the service 

SERVICES()
{
	count1="0"
	count="0"
#	count=`ps -ef | grep -w "$CHATSERVER_EXE" | grep -v grep | wc -l` # Checks the number of active process(es) running
	count=`pidof $prog | wc -w` # Checks the number of active process(es) running

        if [ "$REQ_COUNT" -gt "0" ] && [ "$count" -lt "$REQ_COUNT" ];then # checking for the required process count with actual process count of the service
		down_flag=1
	else
		down_flag=0
	fi
	
	if [ -e "/home/wsadmin/stop_mail_im" ] && [ $down_flag -eq 0 ]; then
         SPL_CASE=1
         FLAG=0
         SENDMAIL $count "chatserver" $REQ_COUNT
	     SPL_CASE=0
         rm -rf /home/wsadmin/stop_mail_im
    fi

	if [ $down_flag -eq 1 ];then
       		echo `ps -eaf | grep "chatserver"` > chat_msg
		stop
		ulimit -s 512
		ulimit -n 8192
		ulimit -c unlimited
		start
		sleep 1
		let mail_count++
			if [ ! -e "/home/wsadmin/stop_mail_im" ];then
                if [ $mail_count -gt 2 ];then
                        let FLAG++
                        if [ "$FLAG" -eq "1" ]; then
                                SENDMAIL $count "chatserver" $REQ_COUNT
								echo 1 > /home/wsadmin/stop_mail_im
                        fi
                else
                        SENDMAIL $count "chatserver" $REQ_COUNT
                fi
			fi
        else
                mail_count=0
        fi
}

##############################################
##### FUNCTIONS DEFINITION ENDS FROM HERE#####
##############################################

################################
##### MAIN startS FROM HERE#####
###############################
if [ -e "$CHATSERVER_EXE" ] && [ -e "$CHATSERVER_CONF" ]; then
	count_time="0"
	while [ "$count_time" -lt "$MAX_TIME" ]
	do
        	count_time=$(($count_time+$SLEEP_TIME))
#       	echo $count_time
		SERVICES
	        sleep $SLEEP_TIME
	done
fi
##############################
##### MAIN ENDS FROM HERE#####
##############################
