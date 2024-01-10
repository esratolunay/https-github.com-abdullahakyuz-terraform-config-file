output "private_subnet_cidrs" {
  value = [for x in aws_subnet.private-subnet : x.cidr_block]
}
output "public_subnet_cidrs" {
   value = aws_subnet.public-subnet[*].cidr_block
 }
output "vpc_cidr" {
    value = aws_vpc.terraform_vpc.cidr_block
 }
 output "vpc_id" {
   value = aws_vpc.terraform_vpc.id
 }
 output "public_subnet_id" {
   value = aws_subnet.public-subnet.id
 }
  output "public_subnet_id" {
   value = aws_subnet.private-subnet.id
 }
 output "default_security_group_id" {
   value = aws_vpc.terraform_vpc.default_security_group_id
 }
 output "default_main-rt-id" {
   value = aws_vpc.terraform_vpc.main_route_table_id
 }