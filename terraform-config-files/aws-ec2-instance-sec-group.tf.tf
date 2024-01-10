terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "first_ter_server" {
  ami            = "ami-08a52ddb321b32a8c"
  instance_type   = "t2.micro"
  key_name        = "esra-key"
  security_groups = [aws_security_group.terraform_sec_group.name]
  tags = {
    Name = "First_Ter_Ins"
  }

}

resource "aws_security_group" "terraform_sec_group" {
  name         = "terraform_sesc_group"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}