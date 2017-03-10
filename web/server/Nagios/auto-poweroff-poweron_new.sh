#!/bin/bash
#Author Md waseem/Sunil penmetsa - Devops
#Function starts Here
echo "#######################"
echo "list of all vms"
echo "#######################"
vim-cmd vmsvc/getallvms
vim-cmd vmsvc/getallvms | grep 'R&D\|Lab\|devops' | awk '{print $1}' > /home/admin/devops/scripts/allvmsvmid.txt
vim-cmd vmsvc/getallvms | grep 'R&D\|Lab\|devops' | awk '{print $2}' > /home/admin/devops/scripts/allvmsname.txt
/home/admin/devops/scripts # cat auto-poweroff-poweron.sh                                                                                                                                       
#!/bin/bash
#Author Md waseem/Sunil penmetsa - Devops
#Function starts Here
echo "#######################"
echo "list of all vms"
echo "#######################"
vim-cmd vmsvc/getallvms
vim-cmd vmsvc/getallvms | grep 'R&D\|Lab\|devops' | awk '{print $1}' > /home/admin/devops/scripts/allvmsvmid.txt
vim-cmd vmsvc/getallvms | grep 'R&D\|Lab\|devops' | awk '{print $2}' > /home/admin/devops/scripts/allvmsname.txt
echo "###########################################"
echo "Servers which are going to be Powered off "
echo "----------------------------------------------"
/bin/cat /home/admin/devops/scripts/allvmsname.txt
echo "##########################################"
echo "VM Status before Power off"
echo "----------------------------------------------"
for i in `cat /home/admin/devops/scripts/allvmsvmid.txt`
do
vim-cmd vmsvc/power.getstate "$i"
done
echo "###########################"
for i in `cat /home/admin/devops/scripts/allvmsvmid.txt`
do
vim-cmd vmsvc/power.off "$i"
done
echo "All Vm's Sucessfully Powered off, wait for 10 sec, tool powers on vm's automatically"
sleep 10
echo "#######################################"                          
echo "Servers which are going to be Power ON "   
echo "----------------------------------------------"
/bin/cat /home/admin/devops/scripts/allvmsname.txt                                         
echo "##########################"                                                             
echo "VM Status before Power ON"                          
echo "----------------------------------------------"
for i in `cat /home/admin/devops/scripts/allvmsvmid.txt`
do                                                      
vim-cmd vmsvc/power.getstate "$i"                       
done
echo "##########################"   
for i in `cat /home/admin/devops/scripts/allvmsvmid.txt`
do
vim-cmd vmsvc/power.on "$i"
done
echo "All Vm's Powered on Sucessfully, please check in vsphere client"
exit 0;
