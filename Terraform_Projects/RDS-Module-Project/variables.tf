variable "cidr_block" {}
variable "vpc_id" {}

variable "azs" {
  type = list(string)
}

variable "db_usernam" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
