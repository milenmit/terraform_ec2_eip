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

resource "aws_key_pair" "key_pair" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCynXS2GOAikLw8HBYlXhiL0vGysSFlg7ncQCk2aeUCZPurH6Oe2R4SLzgr4I7QRNDYWMWOJXEQtPN/7s+cF/aVY6+rEJ/mByPCJcugz2NJtZj3e2zZqaiHa577Ig/CoD4GA1GqMCaLnYdKjPvpuWExUEmsepfXLPhQjLEpo+YMPSXlv5waUTqmVrq/Z1qmg9N7nHKhDZXnz2tx5zfUEZr0OuOtZp0A0xNKXCGMBKTsqHYmebjI6n8v1RvwmiJqKPvo5tFu9DqZPkDJQdPlqOftg9bt6prXL91++80ZKf2wBC3UGJ1Rhk7+57HXbEDR2FYPeif6kAuMDXT7O2AMys/EXxwLYWMsLiiQkOm6ASDmMRlJ4ZsBAKkmLmVlYZIgg/oKSPaZCrEKCjO3hCJq8ovKiQnNC+C5dtYmA+nWDnNvJAa67v0UhBAV3yvdaSMYA97yC2wf+FQeDesgpk5eRHDKhbsffyq2twN82W5TIRrZYMf8DdcbakRdbs8lk7SZxU6mVHTYRgCGTR8QmRPSjYNPuXvPVK5RvbaGPbOfXD8NwRsjSBULTOoiP+blvI9hDJa2mEYyuzR2z23z3eKZDEtAMJGVkI1+mB6TTdmRwgFzHEftwgiAyS5A4QAAy0HJaF0M0qLS7brdKheGlmH+lbtngMcDJuteHXmS2n89/ZlOCQ=="
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "eu-west-1a"
  size              = 50
  type              = "gp3"
  tags = {
    Terraform = "true"
    Name      = "data-volume"
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.instance.id
}
