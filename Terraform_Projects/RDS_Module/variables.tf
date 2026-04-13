
variable "main_region" {
  type = string
}
variable "cider_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type = list(string)
}

variable "vpc_id" {}
