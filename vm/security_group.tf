resource "aws_security_group" "ims_bg" {
  name        = "ec2-ims-communicaton"
  description = "Created by Terraform for SSH/HTTPS/SMTP Access"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["82.146.15.6/32"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["82.146.15.6/32"]
  }
  egress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "HTTPS Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  #  ingress {
  #    description = "HTTP Access"
  #    from_port   = 80
  #    to_port     = 80
  #    protocol    = "tcp"
  #    cidr_blocks = ["0.0.0.0/0"]
  #  }

  ingress {
    description = "SMTP Access"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
    Name      = "allow_ssh/smtp/https"
  }
}