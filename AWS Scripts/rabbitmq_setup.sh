#!/bin/bash

# Update OS with the latest patches
sudo yum update -y

# Enable EPEL repository (required for additional packages)
sudo amazon-linux-extras install epel -y

# Install wget to fetch Erlang and RabbitMQ packages
sudo yum install wget -y

# Add the official RabbitMQ repository for Erlang and RabbitMQ
sudo tee /etc/yum.repos.d/rabbitmq_erlang.repo <<EOL
[rabbitmq_erlang]
name=RabbitMQ Erlang Packages
baseurl=https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/rpm/el/7/\$basearch/
gpgcheck=1
gpgkey=https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/gpg.1548404757.txt
enabled=1
EOL

sudo tee /etc/yum.repos.d/rabbitmq.repo <<EOL
[rabbitmq_rabbitmq-server]
name=RabbitMQ Server
baseurl=https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/rpm/el/7/\$basearch/
gpgcheck=1
gpgkey=https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/gpg.1548404757.txt
enabled=1
EOL

# Install Erlang from the RabbitMQ repository
sudo yum install erlang -y

# Install RabbitMQ from the same repository
sudo yum install rabbitmq-server -y

# Enable and start RabbitMQ service
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# Create RabbitMQ configuration directory
sudo mkdir -p /etc/rabbitmq

# Configure RabbitMQ to allow access from non-localhost
echo "[{rabbit, [{loopback_users, []}]}]." | sudo tee /etc/rabbitmq/rabbitmq.config

# Add RabbitMQ user 'test' with password 'test' and assign admin role
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator

# *Important note* 
### Allows access to RabbitMQ on port 5672 on The AWS Security Group ###

# Restart RabbitMQ service to apply changes
sudo systemctl restart rabbitmq-server

# Check RabbitMQ service status
sudo systemctl status rabbitmq-server
