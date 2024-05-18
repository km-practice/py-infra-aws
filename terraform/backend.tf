terraform {
  backend "s3" {
    bucket         = "km-terraform-state-bucket"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
  }
}

