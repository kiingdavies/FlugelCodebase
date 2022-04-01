variable "aws_region" {
  description = "The AWS region to use to create resources."
  default     = "us-east-2"
}

# variable "key_name" { 
#     description = " SSH keys to connect to ec2 instance" 
#     default     =  "pem key" 
# }

variable "instance_type" { 
    description = "instance type for ec2" 
    default     =  "t2.micro" 
}

variable "security_group" { 
    description = "Name of security group" 
    default     = "websecurity"
}

variable "ami_id" { 
    description = "AMI for Ubuntu Ec2 instance" 
    default     = "ami-0447a12f28fddb066" 
}
