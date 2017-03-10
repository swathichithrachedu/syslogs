#!/bin/bash
#Author Md waseem/Sunil penmetsa - Devops
#Function starts Here
vim-cmd vmsvc/getallvms | grep 'R&D\|Lab\|devops' | awk '{print $1}' > /home/admin/devops/scripts/allvmsvmid.txt
vmid=`/bin/cat /home/admin/devops/scripts/allvmsvmid.txt`
echo "vmid $vmid"
for i in `cat /home/admin/devops/scripts/allvmsvmid.txt`
do
vim-cmd vmsvc/power.off "$i"
done
echo "All Vm's Sucessfully Powered off, wait for 10 sec, tool powers on vm's automatically"
sleep 10
for i in `cat /home/admin/devops/scripts/allvmsvmid.txt`
do
vim-cmd vmsvc/power.on "$i"
done
echo "All Vm's Powered on Sucessfully, please check in vsphere client"
exit 0;