variable "environments" {
  type        = string
  description = "we will use this tag for our environments"
}

variable "owner" {
  description = "we can define the owner of resources"
  type        = string
}

variable "project_name" {
  type        = string
  description = "we can define the project name here"
}

locals {
  common_tags = {
    Environment = var.environments
    Owner       = var.owner
    Project     = var.project_name
  }
}

output "common_global_tags" {
  value = local.common_tags
}
