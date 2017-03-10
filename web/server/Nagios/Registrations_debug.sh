#Registrations Drop Debug Tool
#Author Waseem
#21-06-2013

#!/bin/bash

################################################
##### FUNCTIONS DEFINITION startS FROM HERE#####
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

echo -e "********************************************************************** \n"
echo -e "                   $Bold \t Registrations Drop Accounts                       $Normal \n"
echo -e "********************************************************************** \n"
echo -e "                  $Bold \t\"Welcome to Automated Registrations drop Tool $Normal\" \n"
echo -e "                  $Bold \t\"All access to this Tool is monitored$Normal \" \n"

echo -e "$Bold \tEnter Date  $Normal \n";
echo -e "$Bold \tEX:- Jun 21 00:12: $Normal \n";

read DATE;

if [ "$DATE" = "" ]; then
    echo " Warning! 'DATE parameter should not be empty'"
    echo " PLEASE GO THROUGH THE USER MANUAL"

else

echo -e "**********************************************************************"
echo -e "   $Bold \tStep :1 Registrations Loss Accounts with Count                    $Normal "
echo -e "********************************************************************** \n"
echo "   Count  Account-Name"
TodayDate=`date +%e`;
limiter=9;

if [$TodayDate -lt "10" ];then
	limiter=10;
fi

grep AOR /var/log/messages | grep expired | grep "$DATE" | cut -d ' ' -f$limiter | cut -d '-' -f2,3 | cut -d '@' -f1 | sort | uniq -c



echo -e "\n";
echo -e "********************************************************************** "
#echo -e "  $Bold \t Step :2  Registrations Loss Accounts IP's                  $Normal "
echo -e "  $Bold \t Step :2 Account Name with IP's$Normal "
echo -e "********************************************************************** \n"
#echo "   Count  Account-Name"
#grep "$DATE" /var/log/messages | grep "expired"  |  cut -d ' ' -f9 | cut -d '-' -f2,3 | cut -d':' -f1 | sort | uniq -c

#echo -e "************************************************************************************ "


echo " Count Account with IP"
grep "$DATE" /var/log/messages | grep "expired"  |  cut -d ' ' -f$limiter | cut -d '-' -f2,3 | cut -d':' -f1 | sort | uniq -c

echo -e "********************************************************************** "
echo -e "  $Bold \t Step :3 IP's and Carrier details for the above Accounts.$Normal "
echo -e "********************************************************************** \n"
#

echo "   Count  IP's and Carrier"
grep "$DATE" /var/log/messages | grep "expired"  |  cut -d ' ' -f$limiter | cut -d '-' -f2,3 | cut -d':' -f1 | sort | uniq -c | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' > /home/wsadmin/operations/location.txt


for i in `cat /home/wsadmin/operations/location.txt` ; do
dig -x $i +short | sort | uniq -c | sort -nr
done;


echo -e "\n";
echo -e "********************************************************************** "
echo -e "  $Bold \t Step :4 Send above details to Team$Normal "
echo -e "********************************************************************** \n"


echo -e "\n$Bold \tThanks$Normal "
echo -e "$Bold \tOperations Team$Normal "
echo -e "$Bold \tAuthor : Md Waseem$Normal"
echo -e "$Bold \tDeveloped Date:- 21-06-2013$Normal "


echo -e "\n";

fi

exit 0;


