#! /bin/bash
yum install httpd -y
echo "<h1 color="red">Hello Shriyansh Mankar. </h1>"> /var/www/html/index.html
chkconfig httpd on
service httpd start