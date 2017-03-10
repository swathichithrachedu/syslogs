#NFS MOUNTING SCRIPT
#DATE:-14/MAY/2013


MOUNT_IP=$1

if [[ "$1" = "10.20.48.171" || "$1" = "10.20.48.172" || "$1" = "10.20.48.173" ]] ; then
echo " mount $MOUNT_IP:/opt/var/lib/wsmserver /home/wsadmin/WorksmartNFS/var/lib/wsmserver"
echo " mount $MOUNT_IP:/opt/var/spool/wsmserver /home/wsadmin/WorksmartNFS/var/spool/wsmserver"
echo " mount $MOUNT_IP:/opt/var/spool/wsomserver/wscallrecords /home/wsadmin/WorksmartNFS/var/spool/wsmserver/wscallrecords"
echo " mount $MOUNT_IP:/opt/var/spool/wsacdserver/monitornew /home/wsadmin/WorksmartNFS/var/spool/wsmserver/wsacdcallrecords"

/usr/sbin/sendmail -t -oi  <<EOF
From:nfsmonitor@panterranetworks.com
To:waseem@panterranetworks.com
Subject: NFS MOUNTING : UMS (10.X.X.39)

Hi Team,
NFS Mounting script executed in UMS-39, Please verify once.
Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

else
        echo "Please Check 'NFS MOUNTING IP'"
fi
