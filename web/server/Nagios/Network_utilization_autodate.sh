#!/bin/bash
#Network utilization report
#Date : 28-04-2014
#Author : Mohammed Waseem/Sunil Penmetsa

DATE=""
DATE=`date --date="1 days ago" +"%Y-%m-%d"`
echo $DATE

cd /opt/reports/DailyNetworkBackupReport
java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 107731 $DATE_00:00:00 $DATE_23:59:00

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 107731 $DATE_08:00:00 $DATE_16:59:00

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 566638 $DATE_00:00:00 $DATE_23:59:00

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 566638 $DATE_08:00:00 $DATE_16:59:00

echo "Network Utilization Completed..........................................."

scp network_interface_summary_utilization_107731_$DATE_00-00-00_$DATE_23-59-00.
csv network_interface_summary_utilization_107731_$DATE_08-00-00_$DATE_16-59-00.csv network_interface_summary_utilization_566638_$DATE_00-00-00_$DATE_23-59-00.csv network_interface_summary_utilization_566638_$DATE_08-00-00_$DATE_16-59-00.csv neadmin@172.25.122.242:/home/neadmin/

echo "File transfer completed..................................................."
exit 0;


