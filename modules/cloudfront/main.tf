module "s3_bucket" {
  source = "../s3_bucket"
}


# Create a CloudFront distribution
resource "aws_cloudfront_distribution" "cloudfront-cdn" {
  origin {
    domain_name = module.s3_bucket.s3_bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_access_control.id
    origin_id   = module.s3_bucket.s3_website_configuration_id

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for gudy-bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = module.s3_bucket.s3_website_configuration_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

 

  tags = {
    Environment = "dev"
  }
  
}

resource "aws_cloudfront_origin_access_control" "origin_access_control" {
  name                              = "origin-cloudfront-for-s3-bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


data "aws_iam_policy_document" "cloudfront_oac_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.cloudfront-cdn.arn]
    }
  }
}

# Attach bucket policy to allow CloudFront access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3_bucket.s3_bucket_id

   policy = data.aws_iam_policy_document.cloudfront_oac_access.json

}

