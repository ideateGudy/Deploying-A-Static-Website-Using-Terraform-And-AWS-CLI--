output "s3_bucket_domain_name" {
  value = aws_s3_bucket.gudy-bucket.bucket_regional_domain_name
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.gudy-bucket.arn  
}



output "s3_website_configuration_id" {
  value = aws_s3_bucket_website_configuration.bucket_website_defaults.id
}
output "s3_bucket_name" {
  value = aws_s3_bucket.gudy-bucket.bucket
  
}

output "s3_bucket_id" {
  value = aws_s3_bucket.gudy-bucket.id
  
}



# output "s3_website" {
#   value = aws_s3_bucket_website_configuration.bucket_website_defaults.website_endpoint 
# }

