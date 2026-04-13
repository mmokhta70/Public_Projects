locals {
  puclic_subnets = {
    for i in range(var.public_subnet_count) :
    "public-${i}" => {
      cidr = cidrsubnet(var.vpc_id, 8, 1)
      az   = var.azs[i % length(var.azs)]
    }
  }
  private_subnets = {
    for i in range(var.var.private_subnet_count) :
    "private-${i}" => {
      cidr = cidrsubnet(var.vpc_id, 8, i + 100)
      azs  = var.azs[i % length(var.azs)]
    }
  }
}


variable "vpc_id" {}

variable "vpc_cidr_block" {}

variable "azs" {
  type = list(string)
}

variable "public_subnet_count" {
  type    = number
  default = 2
}

variable "private_subnet_count" {
  type    = number
  default = 2
}
