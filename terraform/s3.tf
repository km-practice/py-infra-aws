resource "aws_s3_bucket" "bbucket" {
  bucket = "kjftypractice-${terraform.workspace}"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bbucket.id
  acl    = "private"
}

