# output "aws_acm_certificate" {
#   value = aws_acm_certificate.domain_certificate
# }
output "acm_certificate_arn" {
  value = aws_acm_certificate.domain_certificate.arn
  
}

output "aws_route53_zone" {
  value = aws_route53_zone.main_hosted_zone
}