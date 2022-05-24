#!/bin/bash

WEBID="web30"
USERNAME="banaan"
PASSWORD="banaan123"

echo "useraccount for  $USERNAME is being created.
Please wait..."

sudo useradd $USERNAME -p $PASSWORD -m -d /home/ubuntu/projecthosting/docker/banaan/www/