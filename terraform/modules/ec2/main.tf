resource "aws_instance" "example" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = "test"
  monitoring           = true
  ebs_optimized        = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = var.instance_name
  }

  # Adding encrypted EBS block
  ebs_block_device {
    device_name = "/dev/sdh"  # Example device name, adjust as necessary
    volume_type = "gp2"       # Example volume type, adjust as necessary
    volume_size = 20          # Example size in GB, adjust as necessary
    encrypted   = true        # Ensure encryption is enabled
  }

  root_block_device {
    encrypted = true
    kms_key_id = aws_kms_key.my_key.arn
  }
}



resource "aws_launch_configuration" "example" {
  name_prefix   = "example-lc-"
  image_id      = var.ami # Assuming you want to use the same AMI as for the aws_instance
  instance_type = var.instance_type

  root_block_device {
    encrypted = true
  }

}