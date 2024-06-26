variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-west-2"
}