terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
}

variable "num_of_buckets" {
	default = 2
} 

variable "s3_bucket_name" {
	default = "esra"
}
variable "users" {
  default = ["santino1", "michael1", "fredo1"]
}


resource "aws_s3_bucket" "tf-s3" {
	#bucket = "${var.s3_bucket_name}-${count.index}"
	#count = var.num_of_buckets
	#count = var.num_of_buckets != 0 ? var.num_of_buckets: 3
  for_each = toset(var.users)
  bucket = "example-tf-s3-bucket-${each.value}"
}
resource "aws_iam_user" "tf-users" {
  for_each = toset(var.users)
  name = each.value
}

output "upper_users" {
  value = [ for i in var.users : upper(i) if length(i) > 6 ]
}
