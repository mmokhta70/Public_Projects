variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy subnets into"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC — used by cidrsubnet() to derive subnet ranges"
}

variable "az_count" {
  type        = number
  description = "Number of availability zones to deploy subnets across"
  default     = 2
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
