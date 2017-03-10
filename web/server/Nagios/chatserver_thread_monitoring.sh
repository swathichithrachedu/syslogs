#Chat server Thread monitoring
#!/bin/bash

CRITICAL="1200"
CHATSERVER_THREAD=""

CHATSERVER_THREAD=`ps -eaT | grep chatserver | wc -l`

if  [ $CHATSERVER_THREAD -ge $CRITICAL ]; then
/usr/sbin/sendmail -t -oi  <<EOF
From:chatserver_thread@panterranetworks.com
To:indiaops@panterranetworks.com
Subject: Critical!!:Chatserver Thread Count Increased in 10.xx.xx.121

Hi Team,
Chatserver thread count increased, please verify and inform engineering team.
Default       : 1200
Present Value : $CHATSERVER_THREAD
Command       : ps -eaT | grep chatserver | wc -l

Thanks,
Operations Team
Panterra Networks
indiaops@panterranetworks.com
800-805-0558

EOF

fi

