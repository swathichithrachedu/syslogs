pid=`pidof wsumserver`
if [ "$pid" != "" ]; then
    echo "WSUMSERVER PID is : '$pid'"
    `/bin/kill -s SIGSEGV $pid`
    /home/wsadmin/wsumserver/usr/sbin/wsumserver -g
    echo "WSUMSERVER Restarted Succesfully"
    echo "WSUMSERVER Core Generated Successfully"
    echo "core file name core.$pid"
else
    echo -e "UMS Process Not Found \n"
    echo -e "Please Check the UMS service Once \n"
    echo -e "<command> < ps -eaf | grep wsumserver > \n"
fi
exit 1; 
