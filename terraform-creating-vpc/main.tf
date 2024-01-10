terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  mytag = "esra-terraform"
}
resource "aws_vpc" "terraform_vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        "Name" = "${local.mytag}-vpc"
    }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        "Name" = "${local.mytag}-igw"
    }
}    

resource "aws_subnet" "public-subnet" {
    count = length(var.public_subnet_cidr)
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = element(var.azs, count.index)
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        "Name" = "${local.mytag}-Public-Sub-${count.index +1}"
    }
}
resource "aws_subnet" "private-subnet" {
    count = length(var.private_subnet_cidr)
    cidr_block = element(var.private_subnet_cidr, count.index)
    availability_zone = element(var.azs, count.index)
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        "Name" = "${local.mytag}-Private-Sub-${count.index +1}"
    }
}
resource "aws_route_table" "publicrt" {
    vpc_id = aws_vpc.terraform_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        "Name" = "${local.mytag}-publicrt"
    }
}
resource "aws_route_table_association" "public_subnet_asso" {
    count = length(var.public_subnet_cidr)
    subnet_id = element(aws_subnet.public-subnet[*].id, count.index)
    route_table_id = aws_route_table.publicrt.id
}
resource "aws_vpc_endpoint" "s3-endpoint" {
  vpc_id = aws_vpc.terraform_vpc.id
  service_name = service_name = "com.amazonaws.us-east-1.s3"
}
resource "aws_vpc_endpoint_route_table_association" "attach-rt-endpoint" {
  route_table_id = aws_vpc.terraform_vpc.main_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.s3-endpoint.id
}