

locals {
  name = "${var.project_name}-${var.environment}"
}

variable "identifier" {
  type = string
  validation {
    condition     = length(var.identifier) > 4
    error_message = "identifier must be larger than 4 characters"
  }
}
variable "engine_version" {
  type    = number
  default = 14
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "storage_size" {
  type    = number
  default = 10
}
variable "db_name" {
  type = string
}

#============ credential config ============#

variable "credential" {
  type = list(object({
    username = string
    password = string
  }))
  sensitive = true
}

#============ network config ============#
#
#------------ sunbnets
variable "private_subnet_ids" {
  type = list(string)
}
#------------ security_group_ids
variable "security_group_ids" {
  type        = list(string)
  description = "RDS security group ids"
}
#
#============ global tagging ============#
variable "tags" {
  type = map(string)
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}
