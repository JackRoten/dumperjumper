resource "aws_s3_bucket" "tfer--dumperjumper-002E-com" {
  bucket        = "dumperjumper.com"
  force_destroy = "false"

  grant {
    id          = "03e9e66904a180ed183593b05c9bf36721249e3a4efad84b47433b8a39deebbb"
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }

  object_lock_enabled = "false"

  policy = <<POLICY
{
  "Statement": [
    {
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Resource": "arn:aws:s3:::dumperjumper.com/*",
      "Sid": "PublicReadGetObject"
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  region        = "us-west-2"
  request_payer = "BucketOwner"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }

      bucket_key_enabled = "true"
    }
  }

  versioning {
    enabled    = "false"
    mfa_delete = "false"
  }

  website {
    index_document = "index.html"
  }
}
