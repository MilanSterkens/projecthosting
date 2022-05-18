#!/bin/bash

WEBID="website$(($RANDOM%10000))"
UID="milansterkens$WEBID"
DOMAIN="milansterkens$WEBID"
MYSQL_VERSION="5.7.13"
MYSQL_USER_ENV="user"
MYSQL_PASSWORD_ENV="password"

echo "configuration for $WEBID is being created.
Please wait..."

#create directory structure
mkdir $WEBID
mkdir $WEBID/www
mkdir $WEBID/php-apache
mkdir $WEBID/mysql

#create nesscecary files
touch $WEBID/docker-compose.yml
touch $WEBID/php-apache/dockerfile
touch $WEBID/www/index.php

echo 'version: "3.1"
services:

 web:
  build: php-apache/.
  restart: always
  depends_on:
  - db
  volumes:
  - ./www:/var/www/html
  expose:
  - "80"
  environment:
   VIRTUAL_HOST: 'web.$DOMAIN.local'
  container_name: 'contweb-$UID'


 db:
  image: mysql:'$MYSQL_VERSION'
  restart: always
  environment:
   MYSQL_DATABASE: 'db'
   MYSQL_USER: '$MYSQL_USER_ENV'
   MYSQL_PASSWORD: '$MYSQL_PASSWORD_ENV'
   MYSQL_ROOT_PASSWORD: '$MYSQL_PASSWORD_ENV'
  expose:
  - "3306"
  container_name: 'contsql-$UID'
  volumes:
  - ./mysql:/var/lib/mysql

 phpmyadmin:
  image: phpmyadmin/phpmyadmin
  expose:
  - "80"
  environment:
   PMA_HOST: 'contsql-$UID'
   MYSQL_USER: '$MYSQL_USER_ENV'
   MYSQL_PASSWORD: '$MYSQL_PASSWORD_ENV'
   MYSQL_ROOT_PASSWORD: '$MYSQL_PASSWORD_ENV'
   VIRTUAL_HOST: 'phpmyadmin.$DOMAIN.local'
  container_name: 'contphpmyadmin-$UID'


networks: 
 default: 
  name: net-hosting' > $WEBID/docker-compose.yml


echo 'FROM php:7.0.30-apache
RUN apt-get update
RUN docker-php-ext-install mysqli' > $WEBID/php-apache/dockerfile


echo "<html>
<head>
 <title>Milestone 2</title>
 <meta charset="utf-8">
<meta http-equiv="refresh" content="8">
</head>
<?php
$conn = mysqli_connect('contsql-$UID', '$MYSQL_USER_ENV', '$MYSQL_PASSWORD_ENV', 'db');
$query = 'SELECT naam From naam';
$result = mysqli_query($conn, $query);
echo '<h1>';
while($value=$result->fetch_array(MYSQLI_ASSOC)){
echo $value['naam'];
}
echo ' is the king of the world!!!</h1>';
$result->close();
mysqli_close($conn);
?>
</body>
</html>" > $WEBID/www/index.php


echo "Finished!"