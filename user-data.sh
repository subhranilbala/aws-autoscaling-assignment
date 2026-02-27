#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Auto Scaling Demo AWS" > /var/www/html/index.html
