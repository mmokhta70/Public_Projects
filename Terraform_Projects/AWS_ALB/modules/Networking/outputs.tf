output "public_subnet_ids" {
  value       = aws_subnet.public_subnet[*].id
  description = "The IDs of the public subnets- for alb and web servers"
}

output "private_subnet_ids" {
     value = aws_subnet.private_subnet[*].id
     description = "The IDs of the private subnets- for db servers"
}

