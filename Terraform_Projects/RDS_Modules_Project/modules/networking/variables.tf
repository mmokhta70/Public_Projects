variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy subnets into"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets, one per availability zone"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets used by RDS, one per availability zone"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones to deploy subnets into (must match length of subnet CIDR lists)"
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
}

variable "environment" {
  type        = string
  description = "Deployment environment: dev, staging, or prod"
}

variable "tags" {
  type        = map(string)
  description = "Common tags from the tags module applied to all resources"
}
