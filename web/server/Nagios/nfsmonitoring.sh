#NFS MONITORING
#AUTHOR MD WASEEM

df -h | grep -Ev '/dev/sda3|/dev/sda1|tmpfs' > /home/wsadmin/waseem/scripts/nfs_new.txt


