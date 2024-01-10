variable "cidr_block" {
    default = "10.10.0.0/16"
}
variable "public_subnet_cidr" {
    type = list(string)
    default = ["10.10.2.0/24","10.10.4.0/24","10.10.6.0/24"]
}
variable "private_subnet_cidr" {
    type = list(string)
    default = ["10.10.1.0/24","10.10.3.0/24","10.10.5.0/24"]
}
variable "azs" {
    type = list(string)
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}