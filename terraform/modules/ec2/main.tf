resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  metadata_options {

       http_endpoint = "enabled"
       http_tokens   = "optional"
 }

  tags = {
    Name = var.instance_name
  }
}