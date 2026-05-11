
variable "cidr_block" {}

variable "project_name" {}

variable "identifier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "instance_class" {
  type = string
}


variable "credential" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
}
