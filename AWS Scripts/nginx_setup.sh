#!/bin/bash

# Update OS with the latest patches
sudo yum update -y

# Install Nginx
sudo amazon-linux-extras install nginx1 -y

# Create Nginx configuration file for the app
sudo tee /etc/nginx/conf.d/vproapp.conf > /dev/null <<EOL
upstream vproapp {
    server app01:8080;
}

server {
    listen 80;
    location / {
        proxy_pass http://vproapp;
    }
}
EOL

# Remove the default Nginx configuration if exists
sudo rm -f /etc/nginx/conf.d/default.conf

# Restart Nginx to apply the new configuration
sudo systemctl restart nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx
