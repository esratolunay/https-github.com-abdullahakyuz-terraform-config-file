terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
resource "aws_instance" "terraform_server" {
    ami = data.aws_ami.amzn-linux-2023-ami.id
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = [aws_security_group.ter-ins-sec-grp.name]
    user_data = <<-EOF
                #! /bin/bash
                dnf update -y
                dnf install -y yum-utils
                yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
                dnf -y install terraform
                EOF
    tags = {
      "Name" = "terraform_server"
    }
}

output "instance_public_ip" {
  value = aws_instance.terraform_server.public_ip 
}

resource "aws_security_group" "ter-ins-sec-grp" {
  name        = "ter-ins-sec-grp"
  description = "Allow SSH inbound traffic"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  #or "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ter-ins-sec-grp"
  }
}

