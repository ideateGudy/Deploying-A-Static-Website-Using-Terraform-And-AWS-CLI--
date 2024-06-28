module "cloudfront" {
  source = "../cloudfront"
}

resource "aws_route53_zone" "main_hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "domain_verification_record" {
  for_each = {
    for dvo in aws_acm_certificate.domain_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  zone_id         = aws_route53_zone.main_hosted_zone.zone_id
}


# resource "aws_route53_record" "website_dns_record" {
#   zone_id = aws_route53_zone.main_hosted_zone.id
#   name    = "www.${var.domain_name}"
#   type    = "A"

#   alias {
#     name                   = module.cloudfront.aws_cloudfront_distribution.website_distribution.domain_name
#     zone_id                = module.cloudfront.aws_cloudfront_distribution.website_distribution.hosted_zone_id
#     evaluate_target_health = false
#   }
# }
