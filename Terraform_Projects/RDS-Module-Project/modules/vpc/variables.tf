variable "cidr_block" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "vpc tagging here"
}


variable "project_name" {
  type = string
}


variable "environment" {
  type = string
}
