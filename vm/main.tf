terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "aws" {
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
  region     = var.aws_region
}

#Creating an instance with security group

resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = "eu-west-1a"
  vpc_security_group_ids = [aws_security_group.ims_bg.id]
  key_name               = "aws_key"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Add key pair to aws - upload public key

resource "aws_key_pair" "key_pair" {
  key_name   = "aws_key"
  public_key = "ssh-rsa************"
}

# Adding 50 gb gp3 hard/EBS additionaly 
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "eu-west-1a"
  size              = 50
  type              = "gp3"
  tags = {
    Terraform = "true"
    Name      = "data-volume"
  }
}

#Attach the added hard/EBS

resource "aws_volume_attachment" "volume_attachment" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.instance.id
}
