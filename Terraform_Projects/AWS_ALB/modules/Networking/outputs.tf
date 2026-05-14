output "public_subnet_ids" {
  value       = aws_subnet.public_subnet[*].id
  description = "The IDs of the public subnets- for alb and web servers"
}

output "private_subnet_ids" {
     value = aws_subnet.private_subnet[*].id
     description = "The IDs of the private subnets- for db servers"
}

output "azs" {
  value = local.azs
  description = "The availability zones used for the subnets"
}

output "public_subnet_cidrs" {
  value = local.public_subnets
  description = "The CIDR blocks of the public subnets"
}


output "private_subnet_cidrs" {
  value = local.private_subnets
  description = "The CIDR blocks of the private subnets"
}