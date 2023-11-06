#variable "aws_access_key" {
#  type    = string
#  default = "xxxxxxxxxxxxxx"
#}

#variable "aws_secret_key" {
#  type    = string
#  default = "xxxxxxxxxxxxxx"
#}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "ami_id" {
  type    = string
  default = "ami-046a9f26a7f14326b"
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}
