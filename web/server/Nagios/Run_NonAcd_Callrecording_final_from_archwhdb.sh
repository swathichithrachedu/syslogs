#NonAcd Call Recordings
#Author Waseem
#! /bin/bash

DBUSER="wsadmin"
DBPASWD="worksmart"
DBNAME="archive_warehousepbx"
DBHOST="10.20.48.104"


SITEID="";
FROMDATE="";
TODATE="";
FILENAME="";

echo -e "*******************Download Acd Call recordings*********************** \n"
echo -e "Enter Siteid \n";

read SITEID;

echo -e "Enter fromdate in the format 'yyyy-mm-dd' \n";

read FROMDATE;

echo -e "Enter todate in the format 'yyyy-mm-dd' \n";
read TODATE;

echo -e "Enter file name in the Format 'filename.xls' \n";
read FILENAME;

echo -e "\nEnter Agent ID ('username@sitename')( or Press Enter for all Agents) \n";

read AGENTID;

AGCOND=""

if test "$AGENTID" != ""
then
        AGCOND="AND fromnum like '%$AGENTID%'"
fi


echo -e "You have Entered  $SITEID ; $FROMDATE  ;  $TODATE ; $AGENTID \n"

mkdir NonAcdrecordinds_$SITEID
cd NonAcdrecordinds_$SITEID


echo -e "Acd Call Recordings Report Generated Succesfully..................\n"

QUERY="SELECT CONCAT(filename,'.mp3') AS 'File Name', CONVERT_TZ(starttime, '-07:00', '-07:00') AS 'Start Time', CONVERT_TZ(endtime, '-07:00', '-07:00') AS 'End Time', TIME_TO_SEC(TIMEDIFF(endtime, starttime)) AS Duration, fromnum AS 'From Num', tonum AS 'To Num', c.calltypename AS 'Call Type' FROM wscallrecorddetails w, calltypes c WHERE c.calltypecode = w.calltype AND siteid = $SITEID $AGCOND AND delflag = 0  AND (recording_mode = 1 OR recording_mode = 2)  AND endtime != '0000-00-00 00:00:00' AND DATE(CONVERT_TZ(starttime, '-07:00', '-07:00')) BETWEEN '$FROMDATE' AND '$TODATE' ORDER BY w.id"

echo -e "Downloading Acd call Recordings.....................................\n"


echo "$QUERY"
	mysql  -h"$DBHOST"  -u"$DBUSER" -p"$DBPASWD"  $DBNAME  -e "$QUERY"  > /opt/callrecording/NonAcd_Callrecordings/$FILENAME

/bin/cp /opt/callrecording/NonAcd_Callrecordings/$FILENAME .

cat /opt/callrecording/NonAcd_Callrecordings/NonAcdrecordinds_$SITEID/$FILENAME | cut -f1 > callrecmp3

sed -i '1d' callrecmp3

cat callrecmp3 | awk '{print echo "curl -d  \"ftype=oms&file="$1,echo"\" http://10.20.48.171/download.php >"  $1;}' > editing.sh

sed "s/mp3 /mp3/g" editing.sh > final.sh

echo -e "Curl command prepared \n"

sh final.sh

echo -e "Downloading Acd Call Recordings...............\n"

echo -e "Acd Call Recordings Downloaded Succesfully...............\n"

echo -e "Started tar...........................................\n"

rm -f $FILENAME callrecmp3 editing.sh final.sh

cd ..
/bin/tar -cvzf NonAcdrecordinds_$SITEID.tar.gz NonAcdrecordinds_$SITEID

echo -e "Tar completed successfully, file name $SITEID.tar.gz \n"

#echo -e "Now preparing Symbolic link.............................\n"

#cd /home/wsftp

#/bin/ln -s /opt/callrecording/NonAcd_Callrecordings/NonAcdrecordinds_$SITEID.tar.gz NonAcdrecordinds_$SITEID.tar.gz
#/bin/ln -s /opt/callrecording/NonAcd_Callrecordings/$FILENAME $FILENAME


#echo -e "Symbolic link prepared sucessfully.................."

#echo -e "FTP Link Below :-.........................."

#echo -e "ftp://wsftp:w0rld\$m@rt@208.77.5.48/NonAcdrecordinds_$SITEID.tar.gz \n"
#echo -e "ftp://wsftp:w0rld\$m@rt@208.77.5.48/$FILENAME \n"



exit 0 ;

