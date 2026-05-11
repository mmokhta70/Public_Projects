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

variable "db_port" {
  type        = number
  description = "Port the database listens on (5432 for PostgreSQL, 3306 for MySQL)"
  default     = 5432
}
