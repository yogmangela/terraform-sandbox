resource "aws_s3_bucket" "codepipeline" {
  bucket = "codepipeline-bucket"

  lifecycle_rule {
    enabled = true

    expiration {
      days = 365
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

output "codepipeline_bucket" {
  value = aws_s3_bucket.codepipeline.bucket
}
