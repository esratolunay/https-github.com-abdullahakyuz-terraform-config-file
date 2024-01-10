variable "instance_type" {
    default = "t2.micro"
}
variable "availability_zones" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "target_value" {
    default = 70.0 
}

variable "desired_capacity" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}

variable "vpc_id" {
  type = string
  default = "vpc-004d6e9bf8a702c55"
}

variable "key_name" {
}

output "load-balancer-dns" {
  value = aws_lb.ELB.dns_name 
}
