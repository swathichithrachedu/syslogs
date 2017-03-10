#######################################################################################
#            Registration Drop Script
#    
#                                                                                       
#                                                                                     
#                                                                                    
#	Author:Md Waseem  (Operation's Team)
###############################################################################

MAX_LIMIT="-25"

TO_MAIL="deployment@panterranetworks.com"

FROM_MAIL="ws_Registrationdrop@panterranetworks.com"

#SUBJECT_LOG="Critical:-Registrations Drop in "

SENDMAIL_FLAG="0"; 

################################################

     ##### FUNCTIONS DEFINITION #####

################################################

 

SENDMAIL_LOG_ALERT() 
{

       {

                echo -e "To: $TO_MAIL"

                echo -e "From: $FROM_MAIL"

                echo -e "Subject: $SUBJECT_LOG"

                echo -e ""

                echo -e "Registration Drop $curdate" 
                echo -e  "------------------------------ \n"
		
		echo "Registration on 36 After 1 min = $var5"
		
		echo -e "Registration on 36 Before 1 min = $var6 \n"

		echo "Registration on 37 After 1 min = $var3"
		
		echo -e "Registration on 37 Before 1 min = $var4 \n"

		echo "Registration on 38 After 1 min = $var1"

         	echo -e "Registration on 38 Before 1 min = $var2 \n"

		echo "Registration Loss/Gain  on Registrar.36  = $Reg36"

		echo "Registration Loss/Gain  on Registrar.37  = $Reg37"

		echo -e "Registration Loss/Gain  on Registrar.38  = $Reg38 \n"
       
                echo -e " Note :- '+' Registrations increased \n"
                echo -e "      :- '-' Registrations Drop \n"
                
		echo -e "Thanks & Regards"
		echo -e "Operations Team"
                echo -e ""


} | /usr/sbin/sendmail -oi -t

}

 

#CREATE_FILE_LOG()

#{

#      `touch /tmp/MSG_LOG.DAT`

#}

 

#DELETE_FILE_LOG()

#{

#        `rm -f /tmp/MSG_LOG.DAT`

#}

 

mysql -uwsadmin -h10.20.48.76 -pworksmart -e"select * from ReportManager.RegMonitor order by montime desc limit 6;" > query.txt
Regcount=`cat -n query.txt | cut -f5 > count.txt`
var1=`head -2 count.txt | tail -1`
var2=`head -5 count.txt | tail -1`
var3=`head -3 count.txt | tail -1`
var4=`head -6 count.txt | tail -1`
var5=`head -4 count.txt | tail -1`
var6=`head -7 count.txt | tail -1`

Reg38=$(($var1 - $var2))

Reg37=$(($var3 - $var4))

Reg36=$(($var5 - $var6))

echo -e "Critical:-Registrations Drop in " > subject

if [ $Reg38 -le $MAX_LIMIT ];then
        echo "CRITICAL: Registrations drop ($Reg38) "
	echo -e "Sending mail ... 38 reg"
	echo -e " .38 " >> subject
	SENDMAIL_FLAG=1;
else
        echo "No Issues Found with Registrations ('+'=Increase '-'=Drop (Current Status ='$Reg38')"
fi

if [ $Reg37 -le $MAX_LIMIT ];then
        echo "CRITICAL: Registrations drop ($Reg37) "
	echo -e "Sending mail ... 37 reg "
	echo -e " .37 " >> subject
	SENDMAIL_FLAG=1;

else
        echo "No Issues Found with Registrations ('+'=Increase '-'=Drop (Current Status ='$Reg37')"
fi

if [ $Reg36 -le $MAX_LIMIT ];then
        echo "CRITICAL: Registrations drop ($Reg36) "
	echo -e "Sending mail ... 36 reg "
	echo -e " .36 " >> subject
	SENDMAIL_FLAG=1;

else
        echo -e "No Issues Found with Registrations ('+'=Increase '-'=Drop (Current Status ='$Reg36') \n"
fi


                echo "Registration on 36 After 1 min = $var5"

                echo -e "Registration on 36 Before 1 min = $var6 \n"

                echo "Registration on 37 After 1 min = $var3"

                echo -e "Registration on 37 Before 1 min = $var4 \n"

                echo "Registration on 38 After 1 min = $var1"

                echo -e "Registration on 38 Before 1 min = $var2 \n"

                echo "Registration Loss/Gain  on Registrar.36  = $Reg36"

                echo "Registration Loss/Gain  on Registrar.37  = $Reg37"

                echo -e "Registration Loss/Gain  on Registrar.38  = $Reg38 \n"

                echo -e " Note :- '+' Registrations increased \n"
                echo -e "      :- '-' Registrations Drop \n"

                echo -e "Thanks & Regards"
                echo -e "Operations Team"

SUBJECT_LOG=`cat subject`

if [ "$SENDMAIL_FLAG" -eq "1" ]; then 

	SENDMAIL_LOG_ALERT

fi
