#------------------- create public and privet subnet based on availability zone -------------------#
locals {
  #------------------- Public Subnets -------------------#
  public_subnets = {
    for i, az in var.azs :
    "public${az}" => {
      cidr = cidrsubnet(var.vpc_cidr, 8, 1)
      az   = az
    }
  }

  #------------------- Private Subnets -------------------#
  private_subnets = {
    for i, az in(var.azs) :
    "private-${az}" => {
      cidr = cidrsubnet(var.vpc_cidr, 8, i + 100)
      az   = az
    }
  }
}

variable "azs" {
  type = list(string)
}

variable "vpc_id" {}

variable "vpc_cidr" {}


variable "tags" {
  type = map(string)
}
