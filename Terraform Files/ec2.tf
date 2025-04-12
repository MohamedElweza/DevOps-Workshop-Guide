resource "aws_instance" "app_server" {
  ami                  = "ami-03392a27e4a01f1e4"
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public_subnet.id
  security_groups      = [aws_security_group.ec2_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  key_name = aws_key_pair.ec2_key.key_name
  

  user_data = <<-EOF
              #!/bin/bash
              LOG_FILE="/var/log/user_data.log"
              
              # Redirect stdout and stderr to the log file
              exec > >(tee -a "$LOG_FILE") 2>&1

              sudo yum update -y
              sudo yum install -y aws-cli memcached mariadb

              echo "export SQS_URL=${aws_sqs_queue.app_queue.id}" >> /etc/environment
              echo "export DB_HOST=${aws_db_instance.rds_instance.address}" >> /etc/environment
              echo "export MEMCACHED_HOST=${aws_elasticache_cluster.memcached.cache_nodes[0].address}" >> /etc/environment
              source /etc/environment

              aws sqs send-message --queue-url $SQS_URL --message-body "Hello from EC2"

              DB_HOST="${aws_db_instance.rds_instance.address}"
              DB_USER="${var.db_username}"
              DB_PASS="${var.db_password}"
              DB_NAME="app_db"

              # Wait for RDS to be available
              sleep 30

              # Connect to RDS and create database and table
              mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "
              CREATE DATABASE IF NOT EXISTS $DB_NAME;
              USE $DB_NAME;
              CREATE TABLE IF NOT EXISTS users (
                  id INT AUTO_INCREMENT PRIMARY KEY,
                  name VARCHAR(100) NOT NULL,
                  email VARCHAR(100) UNIQUE NOT NULL
              );
              "

              echo "Database and table created successfully!"
              EOF

  tags = {
    Name = "Tomcat-Server"
  }
}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "my-ec2-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.ec2_key.private_key_pem
  filename = "my-ec2-key.pem"
}