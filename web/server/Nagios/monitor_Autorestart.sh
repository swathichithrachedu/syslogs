#/bin/bash
#Author Mohd Waseem

var1=""
var2="#00"
ScriptName="All_DB_Replication_Status.sh";
File="/opt/autoscript.txt"

SendMail(){

	echo -e "Data : $1 , $2 \n";

 	/usr/sbin/sendmail -t -oi  <<EOF
	From:auto_restart_monitor@panterranetworks.com
	To: waseem@panterranetworks.com
	Subject: Auto Restart disabled : UMS (10.X.X.39)

	Auto restart disabled for UMS(10.X.X.39), make sure to re-enable.

	Thanks,
	Operations Team
	Panterra Networks
	indiaops@panterranetworks.com
	800-805-0558

EOF


}

var1=`/usr/bin/crontab -l | grep -w "$ScriptName" | awk '{ print $1}' `

if [ "$var1" =  "$var2" ];then

	if [ !-e "$FILE"]; then 
		#Check the file existance , Create a file if it does not extsit and send mail .
		echo -e "File does not exists " > $File;
		SendMail $subject $Body
	fi

fi
