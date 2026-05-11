variable "project_name" {
  type        = string
  description = "Name of the project, used as a prefix in all resource names"
}

variable "owner" {
  type        = string
  description = "Owner of the resources, applied as a tag"
}

variable "cost_center" {
  type        = string
  description = "Cost center code for billing and cost allocation"
}

variable "extra_tags" {
  type        = map(string)
  description = "Optional additional tags merged on top of the standard tag set"
  default     = {}
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC (must be a valid RFC 1918 private range)"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets — must contain exactly 2 entries to match the 2 AZs used in dev"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets used by RDS — must contain exactly 2 entries to match the 2 AZs used in dev"
}

variable "db_port" {
  type        = number
  description = "Port the database listens on (5432 for PostgreSQL, 3306 for MySQL)"
  default     = 5432
}
