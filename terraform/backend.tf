terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    region = "us-west-2"
    key    = ""  # This will be dynamically configured in the workflow
  }
}

