resource "aws_s3_bucket" "gudy-bucket" {
    bucket = "gudy-s3-bucket"
    force_destroy = true
}


resource "aws_s3_object" "site-files" {
    # source = "${path.root}/website-files/${each.value}"
    # for_each = fileset("${path.root}/website-files", "**/*")
    bucket = aws_s3_bucket.gudy-bucket.id
    for_each = fileset("website-files", "**/*")
    key = each.value
    source = "website-files/${each.value}"
    etag = filemd5("website-files/${each.value}")
    content_type = each.value  
}


resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
    bucket = aws_s3_bucket.gudy-bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

# resource "aws_s3_bucket_policy" "bucket_policy" {
#     bucket = aws_s3_bucket.gudy-bucket.id
#     policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "PublicReadGetObject",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "s3:GetObject"
#             ],
#             "Resource": [
#                 "arn:aws:s3:::gudy-bucket/*"
#             ]
#         }
#     ]
#     })
# }



resource "aws_s3_bucket_website_configuration" "bucket_website_defaults" {
    bucket = aws_s3_bucket.gudy-bucket.id
    index_document {
        suffix = var.default_document
    }
    error_document {
        key = var.error_document
    }

  
}















# #--------------------------first layer--------------------------------------
# # Create a CloudFront distribution
# resource "aws_cloudfront_distribution" "cloudfront-cdn" {
#   origin {
#     domain_name = aws_s3_bucket.gudy-bucket.bucket_regional_domain_name
#     origin_id   = "S3-gudy-bucket"

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "CloudFront distribution for gudy-bucket"
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "S3-gudy-bucket"

#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   price_class = "PriceClass_100"

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#   cloudfront_default_certificate = true
#   }
# }

# # Create a CloudFront origin access identity
# resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#   comment = "Origin Access Identity for gudy-bucket"
# }

# data "aws_iam_policy_document" "cloudfront_oac_access" {
#   statement {
#     principals {
#       type        = "Service"
#       identifiers = ["cloudfront.amazonaws.com"]
#     }

#     actions = [
#       "s3:GetObject"
#     ]

#     resources = ["${aws_s3_bucket.gudy-bucket.arn}/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "AWS:SourceArn"
#       values   = [aws_cloudfront_distribution.cloudfront-cdn.arn]
#     }
#   }
# }

# # Attach bucket policy to allow CloudFront access
# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.gudy-bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           AWS = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
#         }
#         Action = "s3:GetObject"
#       Resource = [

#         "${aws_s3_bucket.gudy-bucket.arn}/*"
#         ]
#       }
#     ]
#   })
# }
















# #--------------------------second layer--------------------------------------



# resource "aws_cloudfront_distribution" "cloudfront-cdn" {
#   origin {
#     domain_name = aws_s3_bucket.gudy-bucket.bucket_regional_domain_name
#     origin_access_control_id = aws_cloudfront_origin_access_control.orgin_access.id
#     origin_id   = aws_s3_bucket.gudy-bucket.bucket
#   }

#   enabled             = true
# #   is_ipv6_enabled     = true
#   comment             = "CloudFront distribution for gudy-bucket"
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "S3-gudy-bucket"

#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   price_class = "PriceClass_100"

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }
  

# resource "aws_s3_bucket_policy" "main" {
#   bucket = aws_s3_bucket.gudy-bucket.id
#   policy = data.aws_iam_policy_document.cloudfront_oac_access.json
# }

# resource "aws_cloudfront_origin_access_control" "orgin_access" {
#   name                              = "origin-cloudfront"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

# data "aws_iam_policy_document" "cloudfront_oac_access" {
#   statement {
#     principals {
#       type        = "Service"
#       identifiers = ["cloudfront.amazonaws.com"]
#     }

#     actions = [
#       "s3:GetObject"
#     ]

#     resources = ["${aws_s3_bucket.gudy-bucket.arn}/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "AWS:SourceArn"
#       values   = [aws_cloudfront_distribution.cloudfront-cdn.arn]
#     }
#   }
# }


