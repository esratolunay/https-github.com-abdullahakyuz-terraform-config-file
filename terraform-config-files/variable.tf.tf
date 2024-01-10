variable "ec2_name" {
  default = "web_server"
}

variable "ec2_ami" {
  default = "ami-08a52ddb321b32a8c"
}

variable "ec2_type" {
  default = "t2.micro"
}
output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "terra_s3" {
  value = aws_s3_bucket.terra_s3.region
}
