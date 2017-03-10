#Acd Call Recordings
#Author Waseem
#! /bin/bash

DBUSER="wsadmin"
DBPASWD="worksmart"
DBNAME="warehousepbx"
DBHOST="10.20.48.103"


SITEID="";
FROMDATE="";
TODATE="";
FILENAME="";

echo -e "*******************Download Acd Call recordings*********************** \n"
echo -e "Enter Siteid \n";

read SITEID;

echo -e "Enter fromdate in the format 'yyyy-mm-dd' \n";

read FROMDATE;

echo -e "\nEnter todate in the format 'yyyy-mm-dd' \n";
read TODATE;

echo -e "\nEnter file name in the Format 'filename.xls' \n";
read FILENAME;

echo -e "\nEnter Agent ID ('username@sitename')( or Press Enter for all Agents) \n";

read AGENTID;

AGCOND=""

if test "$AGENTID" != ""
then
        AGCOND=" AND agentid like '%$AGENTID%'"
fi


echo -e "You have Entered  $SITEID ; $FROMDATE  ;  $TODATE ; $AGENTID \n"

mkdir Acdrecordinds_$SITEID
cd Acdrecordinds_$SITEID

#QUERY="SELECT CONCAT(q.callerid,'.mp3') AS 'Rec File Name'FROM queueinfodesc q WHERE q.siteid = '$SITEID' AND (q.dtmf_record = 1 OR q.record = 1 ) AND q.deletedstatus = 0 AND DATE(CONVERT_TZ(FROM_UNIXTIME(q.enteringtime), '-07:00', '-07:00')) BETWEEN '$FROMDATE' AND '$TODATE' ORDER BY q.enteringtime"

QUERY="SELECT (SELECT title FROM special WHERE siteid = q.siteid AND code = q.queuename%1000) AS 'Queue Name', CONCAT(q.callerid,'.mp3') AS 'File Name', q.callername AS 'Caller Name', CONVERT_TZ(FROM_UNIXTIME(q.enteringtime), '-07:00', '-07:00') AS 'Start Time', q.queuetime AS 'Queue Time', q.cause AS Cause, q.duration AS Duration FROM queueinfodesc q WHERE q.siteid = $SITEID  AND (q.dtmf_record = 1 OR q.record = 1 ) AND q.deletedstatus = 0 $AGCOND AND DATE(CONVERT_TZ(FROM_UNIXTIME(q.enteringtime), '-07:00', '-07:00')) BETWEEN '$FROMDATE' AND '$TODATE' ORDER BY q.enteringtime"
#echo -e "Acd Call Recordings Report Generated Succesfully..................\n"


#echo -e "Downloading Acd call Recordings.....................................\n"


echo "$QUERY"
	mysql  -h"$DBHOST"  -u"$DBUSER" -p"$DBPASWD"  $DBNAME  -e "$QUERY"  > /opt/callrecording/Acd_Callrecordings/$FILENAME

/bin/cp /opt/callrecording/Acd_Callrecordings/$FILENAME .

cat /opt/callrecording/Acd_Callrecordings/Acdrecordinds_$SITEID/$FILENAME | cut -f2 > callrecmp3

sed -i '1d' callrecmp3

cat callrecmp3 | awk '{print echo "curl -d  \"ftype=acd&file="$1,echo"\" http://10.20.48.171/download.php >"  $1;}' > editing.sh

sed "s/mp3 /mp3/g" editing.sh > final.sh

echo -e "Curl command prepared \n"

sh final.sh

echo -e "Downloading Acd Call Recordings...............\n"

echo -e "Acd Call Recordings Downloaded Succesfully...............\n"

echo -e "Started tar...........................................\n"

#rm -f $FILENAME.xls callrecmp3 editing.sh final.sh

cd ..
/bin/tar -cvzf Acdrecordinds_$SITEID.tar.gz Acdrecordinds_$SITEID

echo -e "Tar completed successfully, file name Acdrecordinds_$SITEID.tar.gz \n"

#echo -e "Now preparing Symbolic link.............................\n"

#cd /home/wsftp

#/bin/ln -s /opt/callrecording/Acd_Callrecordings/Acdrecordinds_$SITEID.tar.gz Acdrecordinds_$SITEID.tar.gz

#/bin/ln -s /opt/callrecording/Acd_Callrecordings/$FILENAME $FILENAME


#echo -e "Symbolic link prepared sucessfully..................\n"

#echo -e "  FTP Link Below"
#echo -e "..........................\n"
#echo -e "ftp://wsftp:w0rld\$m@rt@208.77.5.48/Acdrecordinds_$SITEID.tar.gz \n"
#echo -e "ftp://wsftp:w0rld\$m@rt@208.77.5.48/$FILENAME  \n"

exit 0 ;

