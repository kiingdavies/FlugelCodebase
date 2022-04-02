output "s3_bucket_name" {
  value = aws_s3_bucket.my-s3-bucket.id
}

output "s3_bucket_region" {
    value = aws_s3_bucket.my-s3-bucket.region
}

output "public_ip" {
    value = aws_s3_bucket.my-s3-bucket.public_ip
}