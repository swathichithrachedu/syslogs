#/bin/sh

count=0

Date=`date "+%Y%m%d"`
#Date=`date +'%H:%M'`

/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/ls -lth /var/log/message* > /home/wsadmin/presense_msg

if [ -e "/home/wsadmin/presense_msg" -a -s "/home/wsadmin/presense_msg" ]; then
        while read INPUT
        do
                if [ $count -eq 1 ]; then
                        TAKE=`echo $INPUT | gawk '{print $9}'`
                        /bin/mv $TAKE /opt/messages_presence_$Date
                        break
                fi
                let count++
        done < /home/wsadmin/presense_msg
fi
/bin/rm -rf /home/wsadmin/presense_msg

count=0

/bin/ls -lth /opt/messages_presence_* > /home/wsadmin/presense_msg

if [ -e "/home/wsadmin/presense_msg" -a -s "/home/wsadmin/presense_msg" ]; then
        while read INPUT
        do
                if [ $count -gt 14 ]; then
                        TAKE=`echo $INPUT | gawk '{print $9}'`
                        /bin/rm -rf $TAKE
                fi
                let count++
        done < /home/wsadmin/presense_msg
fi
/bin/rm -rf /home/wsadmin/presense_msg

