variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  type        = string
  description = "project name"
}

variable "environment" {
  type        = string
  description = "environment name"
}

variable "cidr_block" {
  type        = string
  description = "cidr_block range Ip address"
}

variable "instance_type" {
  type        = string
  description = "Ec2 instance type like t3.micro, t3.large,..."
}

variable "common_tags" {
  type        = map(string)
  description = "common tags for all resources"
  default     = {}
}
