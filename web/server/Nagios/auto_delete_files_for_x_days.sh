#!/bin/bash
#delete reports older than 15 days
#Author - devops
DATE=`date +"%d-%m-%y"`
df -h > /home/devops/deleted_files_log_$DATE.txt
find /opt/reports/DailyNetworkBackupReport/network_interface_summary_utilization*.csv  -mtime +15 >> /home/devops/deleted_files_log_$DATE.txt
find /opt/reports/DailyNetworkBackupReport/network_interface_summary_utilization*.csv  -mtime +15 -exec rm {} \;
df -h >> /home/devops/deleted_files_log_$DATE.txt
exit 0;