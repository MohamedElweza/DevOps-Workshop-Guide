
resource "aws_db_instance" "rds_instance" {
  allocated_storage   = 20
  engine              = "mariadb"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot = true
  port = 3306
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "rds-instance"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.public_subnet.id]
}
