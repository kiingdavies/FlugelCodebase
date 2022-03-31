provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "my-s3-bucket" {
  bucket_prefix = var.bucket_prefix
  acl           = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = {
    Name       = "Flugel"
    Environment = "Dev"
  }

  replication_configuration {
   rules {
      rules {
      id = "rule1"
      owner = "InfraTeam"
      status = "Enabled"
    }
   }
  }
}


