terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  mytag = "web-server-esra"
}
resource "aws_instance" "web_server" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = "esra-key"
  tags = {
    "Name" = "${local.mytag}-come from locals"
  }
}
resource "aws_s3_bucket" "terra_s3" {
  bucket = "terra-bucket-ersin13"
}




