#!/bin/sh

# The main objective of this script is to restart the services when there process(es) are inactive 
# The services will be restarted when the active number of process(es) are less than required number of precess(es)
# If any dependences services are present then there will be restarted along with the main service if there are inactive

. /etc/rc.d/init.d/functions

pkill -9 blagrep

ngrdatetim="$(date +%Y_%m_%d_%H_%M_%S)"
echo $ngrdatetim

#blagrep -t -Wbyline -q -O /opt/mcgraw_captures/brguest_panterra_$ngrdatetim.pcap brguest host "202.65.134.116" -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/mcgrawcomnet_$ngrdatetim.pcap mcgrawcom-net -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/tecogen_$ngrdatetim.pcap tecogen -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/wolfmaryles_$ngrdatetim.pcap wolfmaryles -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/pinnacle_$ngrdatetim.pcap pinnacle -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/johnbovinacom_$ngrdatetim.pcap johnbovina-com -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/gpllc_$ngrdatetim.pcap gpllc -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/lukoilusa_$ngrdatetim.pcap lukoilusa -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/ericholland_$ngrdatetim.pcap ericholland -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/lanvin_$ngrdatetim.pcap lanvin -dbond0.8 > /dev/null &
blagrep -t -Wbyline -q -O /opt/mcgraw_captures/panterranetworks-com_$ngrdatetim.pcap panterranetworks-com -dbond0.8 > /dev/null &


##############################
##### MAIN ENDS FROM HERE#####
##############################
