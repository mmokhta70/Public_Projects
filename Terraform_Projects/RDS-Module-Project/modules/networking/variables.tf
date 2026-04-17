#------------------- create public and privet subnet based on availability zone -------------------#
locals {
  #------------------- Public Subnets 0 - 99 -------------------#
  #------------------- Example: 10.0.0.0 , 10.0.1.0 , 10.0.2.0 , ....
  public_subnets = {
    for i, az in var.azs :
    "public${az}" => {
      cidr = cidrsubnet(var.vpc_cidr, 8, 1)
      az   = az
    }
  }

  #------------------- Private Subnets -------------------#
  #------------------- Example: 10.0.100.0 , 10.0.101.0 , 10.0.102.0 , ....
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
