variable "cidr_block" {
     type = string
     description = "cidr_block range Ip address"
}

variable "vpc_id" {
     type = string
     description = "vpc id"
}

variable "project_name" {
     type = string
     description = "project name"
}

variable "environment" {
     type = string
     description = "environment name"
}    

variable "common_tags" {
     type = map(string)
     description = "common tags for all resources"
     default = {}
}
