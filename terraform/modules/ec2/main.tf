resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  monitoring    = true
  ebs_optimized = true

  metadata_options {

    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = var.instance_name
  }
}