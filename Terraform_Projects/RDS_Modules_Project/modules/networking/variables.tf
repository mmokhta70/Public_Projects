variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy subnets into"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC — used by cidrsubnet() to derive subnet ranges"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zone names to deploy subnets across"
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
