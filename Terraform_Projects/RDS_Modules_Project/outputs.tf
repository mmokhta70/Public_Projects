output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets (used for RDS)"
  value       = module.networking.private_subnet_ids
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group to pass to your RDS instance"
  value       = module.networking.db_subnet_group_name
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = module.security.rds_security_group_id
}

output "app_security_group_id" {
  description = "ID of the application tier security group"
  value       = module.security.app_security_group_id
}