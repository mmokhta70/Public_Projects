variable "vpc_cidr" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Global tags that comes from tags module"
}

variable "project_name" {
     type= string
     description = "this is a project name used or naming the reources"
}


variable "environment" {
     type = string
     description ="this includes dev, prod, stgaing"
}
