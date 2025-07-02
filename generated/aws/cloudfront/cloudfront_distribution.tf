resource "aws_cloudfront_distribution" "tfer--E1K5BY8THDWUUL" {
  aliases                         = ["dumperjumper.com"]
  continuous_deployment_policy_id = "467fb22d-a941-4655-80b7-96b291f24c43"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cache_policy_id = "${aws_cloudfront_cache_policy.tfer--658327ea-f89d-4fab-a63d-7e88639e58f6.id}"
    cached_methods  = ["GET", "HEAD"]
    compress        = "true"
    default_ttl     = "0"

    grpc_config {
      enabled = "false"
    }

    max_ttl                = "0"
    min_ttl                = "0"
    smooth_streaming       = "false"
    target_origin_id       = "dumperjumper.com.s3-website-us-west-2.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"
  }

  default_root_object = "index.html"
  enabled             = "true"
  http_version        = "http2"
  is_ipv6_enabled     = "true"

  origin {
    connection_attempts = "3"
    connection_timeout  = "10"

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_keepalive_timeout = "5"
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = "30"
      origin_ssl_protocols     = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = "dumperjumper.com.s3-website-us-west-2.amazonaws.com"
    origin_id   = "dumperjumper.com.s3-website-us-west-2.amazonaws.com"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = "false"
  staging          = "false"

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:444441211034:certificate/4196cc73-83d9-40c3-916a-447987d454f0"
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "tfer--E21BRIJVRXFLH" {
  continuous_deployment_policy_id = "467fb22d-a941-4655-80b7-96b291f24c43"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cache_policy_id = "${aws_cloudfront_cache_policy.tfer--658327ea-f89d-4fab-a63d-7e88639e58f6.id}"
    cached_methods  = ["GET", "HEAD"]
    compress        = "true"
    default_ttl     = "0"

    grpc_config {
      enabled = "false"
    }

    max_ttl                = "0"
    min_ttl                = "0"
    smooth_streaming       = "false"
    target_origin_id       = "dumperjumper.com.s3-website-us-west-2.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"
  }

  default_root_object = "index.html"
  enabled             = "true"
  http_version        = "http2"
  is_ipv6_enabled     = "true"

  origin {
    connection_attempts = "3"
    connection_timeout  = "10"

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_keepalive_timeout = "5"
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = "30"
      origin_ssl_protocols     = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = "dumperjumper.com.s3-website-us-west-2.amazonaws.com"
    origin_id   = "dumperjumper.com.s3-website-us-west-2.amazonaws.com"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = "false"
  staging          = "true"

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:444441211034:certificate/4196cc73-83d9-40c3-916a-447987d454f0"
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}
