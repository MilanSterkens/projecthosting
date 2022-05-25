#!/bin/bash

WEBID="web2515"
USERNAME="banaan"
PASSWORD="banaan123"

echo "useraccount for  $USERNAME is being created.
Please wait..."


sudo useradd $USERNAME -p $PASSWORD -d /home/ubuntu/projecthosting/docker/$WEBID/www/
sudo chown -R $USERNAME /home/ubuntu/projecthosting/docker/$WEBID/www  
