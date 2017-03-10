#/bin/sh

count=0

Date=`date "+%Y%m%d"`
#Date=`date +'%H:%M'`

/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/ls -lth /var/log/message* > /home/wsadmin/wsinregistrar_wsobproxy_msg

if [ -e "/home/wsadmin/wsinregistrar_wsobproxy_msg" -a -s "/home/wsadmin/wsinregistrar_wsobproxy_msg" ]; then
        while read INPUT
        do
                if [ $count -eq 1 ]; then
                        TAKE=`echo $INPUT | gawk '{print $9}'`
                        /bin/mv $TAKE /opt/messages_wsinregistrar_wsobproxy_$Date
                        break
                fi
                let count++
        done < /home/wsadmin/wsinregistrar_wsobproxy_msg
fi
/bin/rm -rf /home/wsadmin/wsinregistrar_wsobproxy_msg

count=0

/bin/ls -lth /opt/messages_wsinregistrar_wsobproxy_* > /home/wsadmin/wsinregistrar_wsobproxy_msg

if [ -e "/home/wsadmin/wsinregistrar_wsobproxy_msg" -a -s "/home/wsadmin/wsinregistrar_wsobproxy_msg" ]; then
        while read INPUT
        do
                if [ $count -gt 14 ]; then
                        TAKE=`echo $INPUT | gawk '{print $9}'`
                        /bin/rm -rf $TAKE
                fi
                let count++
        done < /home/wsadmin/wsinregistrar_wsobproxy_msg
fi
/bin/rm -rf /home/wsadmin/wsinregistrar_wsobproxy_msg
