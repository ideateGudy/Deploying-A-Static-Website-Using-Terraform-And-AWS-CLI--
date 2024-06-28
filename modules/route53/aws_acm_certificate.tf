

resource "aws_acm_certificate" "domain_certificate" {
  domain_name       = var.domain_name
  subject_alternative_names = ["${var.sub_domain_name}"]
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_verification_record : record.fqdn]
}