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
