#! /bin/bash
yum install httpd -y
echo "<h1>This is my Webserwer </h1>"> /var/www/html/index.html
chkconfig httpd on
service httpd start