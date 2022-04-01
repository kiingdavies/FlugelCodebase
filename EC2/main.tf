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

# Default Vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }  

}

#Create security group with firewall rules
resource "aws_security_group" "security" {
  name        = var.security_group
  description = "Allows ssh and http connection"
  vpc_id = aws_default_vpc.default.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "websecuritygroup"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name= aws_key_pair.key.key_name
  security_groups =  [var.security_group]

 connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = tls_private_key.webkey.private_key_pem
    host     = aws_instance.web.public_ip
  }

 provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",	
     ]
  }

  tags = {
    Name = "WebOS"
  }
}
