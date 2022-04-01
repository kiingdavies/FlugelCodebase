variable "aws_region" {
  description = "The AWS region to use to create resources."
  default     = "us-east-2"
}

variable "bucket_prefix" {
    type        = string
    description = "(required since we are not using 'bucket') Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
    default     = "my-s3bucket-"
}

# variable "versioning" {
#     type        = bool
#     description = "(Optional) A state of versioning."
#     default     = true
# }

# variable "acl" {
#     type        = string
#     description = " Defaults to public-read"
#     default     = "public-read"
# }

variable "tag" {
    type        = string
    description = "The name of the S3 bucket tag"
    default     = "Flugel"
}
