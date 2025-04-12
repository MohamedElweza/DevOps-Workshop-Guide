#!/bin/bash

# Update OS with the latest patches
sudo yum update -y

# Install memcached
sudo yum install -y memcached

# Configure memcached to listen on all interfaces
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached

# Start and enable memcached
sudo systemctl start memcached
sudo systemctl enable memcached

# Start memcached with custom UDP and TCP port settings
sudo memcached -p 11211 -U 11111 -u memcached -d