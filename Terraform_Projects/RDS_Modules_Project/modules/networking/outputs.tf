output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets (used for the RDS DB subnet group)"
  value       = [for s in aws_subnet.private : s.id]
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group to pass to the RDS instance"
  value       = aws_db_subnet_group.main.name
}

output "internet_gateway_id" {
  description = "ID of the internet gateway attached to the VPC"
  value       = aws_internet_gateway.main.id
}
