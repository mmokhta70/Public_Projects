#------------------- configure global tagging variables here
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "environment must be dev, staging, or prod"
  }
}

variable "project_name" {
     type = string
     description = "name of the project"
}

variable "owner" {
     type = string
     description = "Owner of the resources"
}

variable "cost_center" {
  type        = string
  description = "Cost center for billing"
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "we can add more tags here"
}
