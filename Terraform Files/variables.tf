
variable "aws_region" { 
    default = "us-west-1" 
    }

variable "instance_type" { 
    default = "t2.micro" 
    }

variable "db_username" { 
    default = "admin"
     }

variable "db_password" { 
    default = "admin123"
    sensitive = true
     }


variable "vpc_cidr" {
     default = "10.0.0.0/16"
      }

variable "subnet_cidr_1" { 
    default = "10.0.1.0/24" 
    }

variable "subnet_cidr_2" { 
    default = "10.0.2.0/24" 
    }