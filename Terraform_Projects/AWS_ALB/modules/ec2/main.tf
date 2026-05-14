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

