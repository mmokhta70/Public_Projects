#----------------- global tagging variables -----------------#
variable "project_name" {
  type        = string
  description = "this is project name"
}

variable "owner" {
  type        = string
  description = "this is owner of the resources"
}

variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "environments should include : dev, prod , staging"
  }
}

variable "cost_centre" {
  type = string
}


variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "we csutomise our tags"
}
