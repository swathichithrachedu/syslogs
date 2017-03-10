#!/bin/sh

# The main objective of this script is to generate the pcap files in the current-date directory  
#Removes pcap files which are older than N number of days. Here N=15

. /etc/rc.d/init.d/functions

pkill -9 blagrep

noofdays=15
count=1
ngrdatetim="$(date +%Y_%m_%d_%H_%M_%S)"
dirname="$(date +%Y%m%d)"
dirpath="/opt/pcap_captures"
rotate_flag=0

if [ ! -d "$dirpath/$dirname" ];then
	echo "directory name".$dirpath
	/bin/mkdir -p $dirpath/$dirname
	rotate_flag=1
fi

echo $dirpath/$dirname	

blagrep -t -Wbyline -q -O $dirpath/$dirname/mcgrawcomnet_$ngrdatetim.pcap mcgrawcom-net -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/tecogen_$ngrdatetim.pcap tecogen -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/wolfmaryles_$ngrdatetim.pcap wolfmaryles -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/pinnacle_$ngrdatetim.pcap pinnacle -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/johnbovinacom_$ngrdatetim.pcap johnbovina-com -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/gpllc_$ngrdatetim.pcap gpllc -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/lukoilusa_$ngrdatetim.pcap lukoilusa -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/ericholland_$ngrdatetim.pcap ericholland -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/lanvin_$ngrdatetim.pcap lanvin -dany > /dev/null &
blagrep -t -Wbyline -q -O $dirpath/$dirname/panterranetworks-com_$ngrdatetim.pcap host "202.65.134.116" -dany > /dev/null &

#blagrep -t -Wbyline -q -O $dirpath/$dirname/seqfin_IP_74.3.105.154_$ngrdatetim.pcap host "74.3.105.154" -dany > /dev/null &
#blagrep -t -Wbyline -q -O $dirpath/$dirname/seqfin_IP_96.40.172.102_$ngrdatetim.pcap host "96.40.172.102" -dany > /dev/null &

if [ "$rotate_flag" = "1" ]; then

	/bin/ls -lth $dirpath | grep ^d > /home/wsadmin/monitor_call_msg

	if [ -e "/home/wsadmin/monitor_call_msg" -a -s "/home/wsadmin/monitor_call_msg" ]; then
	while read INPUT
		do 
			if [ $count -gt $noofdays ]; then
				DIR=`echo $INPUT | gawk '{print $9}'`
				/bin/rm -rf $dirpath/$DIR
			fi
			let count++
		done < /home/wsadmin/monitor_call_msg
	fi
	/bin/rm -rf /home/wsadmin/monitor_call_msg
fi
