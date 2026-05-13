
variable "vpc_id" {
  type        = string
  description = "VPC_ID"
}
variable "project_name" {
  type        = string
  description = "value"
}

variable "environment" {
  type        = string
  description = "environment name (dev, prod, stagging)"
}


variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "tags comes from commn_tags for resources"
}
