variable "project_name" {
  type        = string
  description = "name of the project"
}

variable "environment" {
  type        = string
  description = "environment includes prod, dev, stagging"
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "public subnet ids for alb"
}


variable "alb_sg_id" {
  type        = string
  description = "alb seurity group id that comes form security group module"
}

variable "common_tags" {
  type    = map(string)
  default = {}
}



variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPs, if is empty => no https listener"
  default     = ""
}
