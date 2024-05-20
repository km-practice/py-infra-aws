output "instance_id" {
  value = module.example.instance_id
}

output "kms_key_arn" {
  value = aws_kms_key.mykey.arn
  description = "The ARN of the KMS key"
}