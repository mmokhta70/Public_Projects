variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
     type = string
     description = "project name"
}

variable "environment" {
     type = string 
     description = "environment name"
}