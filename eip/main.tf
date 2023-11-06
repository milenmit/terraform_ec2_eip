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
  region = var.aws_region
}

data "terraform_remote_state" "remote_tf_state" {
  backend = "local"

  config = {
    path = "../vm/terraform.tfstate"
  }
}

resource "aws_eip" "ims_comm-eip" {
  instance = data.terraform_remote_state.remote_tf_state.outputs.instance_id
  tags = {
    Terraform = "true"
    Name      = "ip assigned from aws elastic"
  }
}
