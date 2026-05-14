variable "instance_type" {
type = string
description = "The type of instance like t2.micro, t3.micro, etc."
validation {
  condition = contains (["t3.micro", "t3.medium", "t3.large"], var.instance_type)
  error_message = "Please make sure you choose the correct instance type. Allowed values are: t3.micro, t3.medium, t3.large."
  }
}


variable "project_name" {
     type = string
     description = "The name of the project to which the instance belongs."
}

variable "environment" {
     type = string
     description = "The environment in which the instance will be deployed (e.g., dev, staging, prod)."
}


variable "Private_subnet" {
     type = list(string)
     description = "A list of private subnet IDs"
}

variable "public_subnet" {
     type = lsit(string)
     description = " list of all public subnet IDs"
}
variable "sg_public" {
     type = string 
     description = "The ID of the public security group - allowinf trrafic comes through the web servers"
}


variable "sg_private" {
     type = string
      description = "The ID of the private security group - alloowing traffic comes through the DBs"
}
