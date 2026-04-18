locals {
  name = "${var.project_name}-${var.environment}"
}


variable "project_name" {
  type = string
}

variable "vpc_id" {

}

variable "environment" {
  type = string
}

#==================== define ingress ports variable
variable "ingress_config" {
  type = list(object[{
    from_port       = number
    to_port         = number
    cidr_block      = optional(list(string), [])
    security_groups = optinal(list(string), [])
    desciption      = string
  }])
  default = []
}


variable "tags" {
  type = map(string)
}
