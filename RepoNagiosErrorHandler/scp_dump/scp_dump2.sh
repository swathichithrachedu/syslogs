#!/usr/bin/expect -f

# connect via scp
spawn scp "wsadmin@10.20.48.121:/home/wsadmin/" /home/wsdamin/wslog-1383150043-278464-pid-495.log
#######################123
expect {
-re ".*es.*o.*" {
exp_send "yes\r"
exp_continue
}
-re ".*sword.*" {
exp_send "m@gicnoodl3s\r"
}
}
interact

