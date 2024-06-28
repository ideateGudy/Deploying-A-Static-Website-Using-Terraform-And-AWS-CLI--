output "s3_website" {
  value = module.my-bucket
}

output "cloudfront_website_url" {
  value = module.cloudfront.cloudfront_website_url
  
}