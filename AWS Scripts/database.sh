#!/bin/bash

# Update OS with the latest patches
sudo yum update -y

# Install git and MariaDB from the repository
sudo yum install -y git mariadb mariadb-server

# Start and enable mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MariaDB installation
sudo mysql_secure_installation <<EOF
Y
admin123
admin123
Y
n
Y
Y
EOF

# Set up the database and users
sudo mysql -u root -padmin123 <<MYSQL_SCRIPT
CREATE DATABASE accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Clone the vProfile project and initialize the database
cd /home/ec2-user
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql

# Restart mariadb-server
sudo systemctl restart mariadb

# Security group firewall rules should be configured in the AWS Management Console
# *Important note* 
# Example: Open port 3306 for MariaDB in your EC2 instance's security group

echo "MariaDB setup completed and database initialized."