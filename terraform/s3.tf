resource "aws_s3_bucket" "bbucket" {
  bucket = "kjftypractice-${terraform.workspace}"
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.bbucket.id

  rule {
    id     = "expire"
    status = "Enabled"

    filter {
      prefix = "logs/"  # Ensure the case matches the prefix used in your S3 bucket
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}



resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bbucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "access_good_1" {
  bucket = aws_s3_bucket.bbucket.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_sns_topic" "bucket_notifications" {
  name = "bucket-notifications"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bbucket.id

  topic {
    topic_arn     = aws_sns_topic.bucket_notifications.arn
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "logs/"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "good_sse_1" {
  bucket = aws_s3_bucket.bbucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.bbucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}
