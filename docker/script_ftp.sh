#!/bin/bash

WEBID="EEEEEEEEEEEEE"
SFTP_USERNAME="jordy"
SFTP_PASSWORD="jordy"

echo "useraccount for  $SFTP_USERNAME is being created.
Please wait..."

PASS=$(perl -e 'print crypt($ARGV[0], "password")' $SFTP_PASSWORD)

#in future, this line can be deleted
mkdir /home/ubuntu/projecthosting/docker/$WEBID
sudo useradd $SFTP_USERNAME -p $PASS -m -d /home/ubuntu/projecthosting/docker/$WEBID/www

sudo chown -R $SFTP_USERNAME /home/ubuntu/projecthosting/docker/$WEBID/www  


echo $SFTP_USERNAME >> /etc/vsftpd.userlist

echo "finished"