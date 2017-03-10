#Author Md Waseem
for i in `cat /home/wsadmin/waseem/scripts/location.txt` ; do
traceroute $i
done;
