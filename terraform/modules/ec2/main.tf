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

  # Assuming this EC2 instance will have additional EBS volumes:
  ebs_block_device {
    device_name = "/dev/sdh"  # Example device name, adjust as necessary
    encrypted   = true
    volume_size = 50          # Example size in GB, adjust as necessary
    delete_on_termination = true
  }
}


resource "aws_launch_configuration" "example" {
  name_prefix   = "example-lc-"
  image_id      = var.ami  # Assuming you want to use the same AMI as for the aws_instance
  instance_type = var.instance_type

  root_block_device {
    encrypted = true
  }

}