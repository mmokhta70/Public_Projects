variable "environment" {
  type = string
  validation {
    condition     = contains([dev, prod, staging], var.environemt)
    error_message = "environmet must be dev, prod , or staging"
  }
}

variable "project_name" {
  type        = string
  description = "name of the project"
}

variable "team" {
  type        = string
  description = "name of team"
}


variable "department " {
  type        = string
  description = "name of department"
}

variable "owner" {
  type        = string
  description = "Owner of the resources"
}

variable "cost_center" {
  type        = string
  description = "Cost center for billing"
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "more tags on top of the standard tags"
}
