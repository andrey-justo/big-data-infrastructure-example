#!/bin/bash

source "/vagrant/scripts/common.sh"

echo "setup mysql"

wget -q http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum -y update
yum install -y mysql-server
sudo service mysql restart

# Set the DB root password
echo "setup mysql schema for hive"
mysql -u root -e "DROP DATABASE IF EXISTS metastore_db;"
mysql -u root -e "CREATE DATABASE metastore_db;"
mysql -u root -e "CREATE DATABASE ranger;"
mysql -u root -e "CREATE DATABASE ranger_audit;"
mysql -u root -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin';"
mysql -u root -e "FLUSH PRIVILEGES;"
