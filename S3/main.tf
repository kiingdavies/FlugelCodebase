provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "my-s3-bucket" {
  bucket_prefix = var.bucket_prefix
  # acl           = var.acl

  # versioning {
  #   enabled = true
  # }

  tags = {
    Name = var.tag
    Environment = var.tag2
  }

}


