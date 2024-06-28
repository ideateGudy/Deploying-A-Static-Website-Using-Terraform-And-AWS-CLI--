output "cloudfront_website_url" {
  value = aws_cloudfront_distribution.cloudfront-cdn.domain_name
  
}

output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.cloudfront-cdn
}

