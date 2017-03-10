root@www53:/home/devops# crontab -l
# m h  dom mon dow   command
25 13 * * * /home/devops/Auto_itmabackup_sendmail.sh

cat /home/devops/Auto_itmabackup_sendmail.sh
#!/bin/bash
#Auto ITMA dump and send mail
#Author DevOps
mysqldump -u root itma > /home/devops/itma_dbbackup/itma_database_dump.sql
cd /home/devops/itma_dbbackup/
/bin/tar -cvzf itma_database_dump.sql.tar.gz itma_database_dump.sql
echo "Hi Chris/Roycey,
Please find the ITMA Database attachment.

Note: This is an automated email from DevOps Tool,please do not reply.

Regards,
DevOps Team" | mutt -a "/home/devops/itma_dbbackup/itma_database_dump.sql.tar.gz" -s "ITMA Database Dump" --  chris.joseph@netenrich.com Roycey.cheeran@netenrich.com alluri.raju@netenrich.com waseem.mohammed@netenrich.com sunil.penmetsa@netenrich.com
rm /home/devops/itma_dbbackup/itma_*
exit 0;
