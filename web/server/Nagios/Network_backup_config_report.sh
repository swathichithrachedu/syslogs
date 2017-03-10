#!/bin/bash
#Network Backup Config report
#Date : 28-04-2014
#Author : Mohammed Waseem/Sunil Penmetsa

cd /opt/reports/DailyNetworkBackupConfigReport
java -cp /opt/reports/DailyNetworkBackupConfigReport:/opt/reports/DailyNetworkBackupConfigReport/lib/* DailyNetworkBackupConfigChangeReportHTML2 107731
java -cp /opt/reports/DailyNetworkBackupConfigReport:/opt/reports/DailyNetworkBackupConfigReport/lib/* DailyNetworkBackupConfigChangeReportHTML2 566638

echo "Report Generated"
scp DailyNetworkBackupConfigChangeReport_107731.html DailyNetworkBackupConfigChangeReport_566638.html neadmin@172.25.122.242:/home/neadmin/
echo "File Transfer Completed"
exit 0;