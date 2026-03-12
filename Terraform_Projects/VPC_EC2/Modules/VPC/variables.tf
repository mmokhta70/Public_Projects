variable "vpc_cidr" {
  description = "create a cidr_block variable"
  type        = string
}

variable "public_subnet_cidr" {
  description = "create a public subnet cider_block"
  type        = string
}

variable "private_cidr_block" {
  description = "cider_block IP address"
  type        = string
}
