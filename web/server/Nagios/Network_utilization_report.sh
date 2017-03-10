#!/bin/bash
#Network utilization report
#Date : 28-04-2014
#Author : Mohammed Waseem/Sunil Penmetsa
################################################
##### FUNCTIONS DEFINITION starts FROM HERE#####
################################################
/usr/bin/clear
Bold="\033[1m"               #Storing escape sequences in a variable.
Normal="\033[0m"


#####################################################################
#                      Define Functions Here                        #
#####################################################################


exit_function()
{
   clear
   exit
}

#Function enter is used to go  back to menu and clears screen

#####################################################################
#                         Main Scricpt                              #
#####################################################################

echo  "********************************************************************** \n"
echo  "                   $Bold \t Network utilization Report                      $Normal \n"
echo  "********************************************************************** \n"
echo  "                  $Bold \t\"Welcome to Automated Network Utilization Tool $Normal\" \n"
echo  "                  $Bold \t\"All access to this Tool is monitored$Normal \" \n"

echo  "$Bold \tEnter From Date  $Normal \n";
echo  "$Bold \tEX:- 2014-04-27: $Normal \n";

read FROMDATE;

if [ "$FROMDATE" = "" ]; then
    echo " Warning! 'DATE parameter should not be empty'"
    echo " PLEASE GO THROUGH THE USER MANUAL"

echo  "$Bold \tEnter To Date  $Normal \n";
echo  "$Bold \tEX:- 2014-04-27: $Normal \n";

read DATE;

if [ "$TODATE" = "" ]; then
    echo " Warning! 'DATE parameter should not be empty'"
    echo " PLEASE GO THROUGH THE USER MANUAL"


else

cd /opt/reports/DailyNetworkBackupReport
echo "You have entered Date:$DATE"

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 107731 $FROMDATE_00:00:00 $TODATE_23:59:00

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 107731 $FROMDATE_08:00:00 $TODATE_16:59:00

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 566638 $FROMDATE_00:00:00 $TODATE_23:59:00

java -cp /opt/reports/DailyNetworkBackupReport:/opt/reports/DailyNetworkBackupReport/lib/* NetworkInterfaceUtilization_new 566638 $FROMDATE_08:00:00 $TODATE_16:59:00

echo "Network Utilization Completed..........................................."

scp network_interface_summary_utilization_107731_$FROMDATE_00-00-00_$TODATE_23-59-00.csv network_interface_summary_utilization_107731_$FROMDATE_08-00-00_$TODATE_16-59-00.csv network_interface_summary_utilization_566638_$FROMDATE_00-00-00_$TODATE_23-59-00.csv network_interface_summary_utilization_566638_$FROMDATE_08-00-00_$TODATE_16-59-00.csv neadmin@172.25.122.242:/home/neadmin/

echo "File transfer completed..................................................."

fi
exit 0;

