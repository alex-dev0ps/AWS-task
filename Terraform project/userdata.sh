#!/bin/bash  
sudo yum install httpd -y 
sudo yum install epel-release -y 
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm 
sudo yum-config-manager --enable remi-php74 
sudo yum install php -y 
sudo yum install amazon-linux-extras -y
sudo amazon-linux-extras enable php8.1
sudo yum clean metadata
sudo yum install php-cli php-pdo php-fpm php-json php-mysqlnd -y
sudo systemctl restart httpd 
sudo systemctl enable httpd 
sudo yum install wget -y 
wget https://wordpress.org/latest.tar.gz 
sudo tar -xf latest.tar.gz -C /var/www/html/ 
sudo mv /var/www/html/wordpress/* /var/www/html/ 
sudo yum install  php-mysqlnd mysql -y 
sudo systemctl restart httpd 
getenforce 
sudo sed 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/sysconfig/selinux -i 
setenforce 0
sudo chown -R apache:apache /var/www/html/
sudo systemctl restart httpd
sudo touch /var/www/html/healthcheck.html