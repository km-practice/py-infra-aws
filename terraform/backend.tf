terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "path/to/your/terraform.tfstate"
    region = "us-west-2"
  }
}
