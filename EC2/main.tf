provider "aws" {
  region = var.aws_region
}

# Key Creation
resource "tls_private_key" "webkey" {
  algorithm   = "RSA"
  rsa_bits = 2048
}

resource "local_file" "private_key" {
    content     = tls_private_key.webkey.private_key_pem
    filename = "mywebkey.pem"
    file_permission = 0400	
}


resource "aws_key_pair" "key" {
  key_name   = "websitekey"
  public_key = tls_private_key.webkey.public_key_openssh
}

#Create security group with firewall rules
resource "aws_security_group" "security_jenkins_grp" {
  name        = var.security_group
  description = "security group for terraform"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound rule
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "terraform_elastic_ip"
  }
}