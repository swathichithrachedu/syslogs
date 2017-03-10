#! /bin/bash
#Author Md Waseem
#Devwloped Date :- 08-07-2013

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
echo -e "                   $Bold \t Auto CDR Downloading Tool                  $Normal \n"
echo -e "********************************************************************** \n"
echo -e "                  $Bold \t\"All access to this Tool is monitored$Normal \" \n"


DBUSER="wsadmin"
DBPASWD="worksmart"
DBNAME="archive_warehousepbx"
DBHOST="10.20.48.104"


ACCOUNTNAME_EXPECTED="";
ACCOUNTNAME="";
FROMDATE="";
TODATE="";
FILENAME="";

echo -e "$Bold \tEnter Account Name :-$Normal  \n";

read ACCOUNTNAME_EXPECTED;

QUERY1="show tables like '%$ACCOUNTNAME_EXPECTED%'"

#echo $QUERY1
mysql  -h"$DBHOST"  -u"$DBUSER" -p"$DBPASWD"  $DBNAME  -e "$QUERY1" 

echo -e "$Bold \tselect Account name from the above tables$Normal \n"

read ACCOUNTNAME;


echo -e "$Bold \t Enter fromdate in the format 'yyyy-mm-dd'$Normal \n";
read FROMDATE;

echo -e "\n $Bold \t Enter todate in the format 'yyyy-mm-dd'$Normal \n";
read TODATE;

echo -e "\n $Bold \tEnter file name in the Format 'filename.xls'$Normal \n";
read FILENAME;

echo -e "$Bold \tPlease wait CDR Downloading ............................$Normal \n"
echo -e "$Bold \t........................................................$Normal \n"
echo -e "$Bold \t........................................................$Normal \n"
echo -e "$Bold \t........................................................$Normal \n"

QUERY2="select from_uri AS 'FROM NUMBER', to_uri AS 'TO NUMBER', duration AS 'DURATION', start_time AS 'START TIME', end_time AS 'END TIME', calltypename AS 'CALL TYPE' from $ACCOUNTNAME  a,calltypes c where (date(start_time) between '$FROMDATE' and '$TODATE') and calltype=calltypecode"
#echo $QUERY2
mysql  -h"$DBHOST"  -u"$DBUSER" -p"$DBPASWD"  $DBNAME  -e "$QUERY2" > /home/wsadmin/operations/$FILENAME

echo -e "$Bold \t CDR for the Account :- $ACCOUNTNAME Downloaded Successfully...........................$Normal "

echo -e "$Bold \t CDR sent to your mail ..............................$Normal \n"

SUBJECT="CDR for the account $ACCOUNTNAME_EXPECTED";
echo | mutt -s "$SUBJECT" -a $FILENAME 'indiaops@panterranetworks.com' <<EOF

Hi Team,
        Please find the cdr attachment.
Thanks
Operations Team
PanTerra Networks
Operations Engineering
(800) 805-0558 ext-1079
indiaops@panterranetworks.com

EOF


echo -e "$Bold \t........................................................$Normal \n"
echo -e "$Bold \t........................................................$Normal \n"
echo -e "$Bold \t........................................................$Normal \n"
echo -e "$Bold \tAuto CRD Download Tool is Copyright © by MOperations Team , All Rights Reserved. $Normal"
echo -e "$Bold \t........................................................$Normal \n"
echo -e "$Bold \t........................................................$Normal \n"
exit 0
