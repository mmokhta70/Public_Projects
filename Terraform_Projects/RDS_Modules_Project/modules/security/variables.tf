variable "vpc_id" {
  type        = string
  description = "ID of the VPC to create security groups in"
}

variable "db_port" {
  type        = number
  description = "Port the database listens on (5432 for PostgreSQL, 3306 for MySQL)"
  validation {
    condition     = var.db_port > 0 && var.db_port <= 65535
    error_message = "db_port must be between 1 and 65535."
  }
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