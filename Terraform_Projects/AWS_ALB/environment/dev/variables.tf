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

variable "certification_arn" {
  type        = string
  description = "ACM certificate for HTTPS traffic only"
  default     = ""
}

#=====================================
# tagging varaiables
# ====================================
variable "owner" {
  type        = string
  description = "Mehrdad.Mokhtari1370@gmail.com"
}

variable "team" {
  type        = string
  description = "name of the Team"
}

variable "cost_center" {
  type        = string
  description = "cost center billing code"
}
