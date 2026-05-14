#====================================
# fetch all the az in your region 
#====================================

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = data.aws_availability_zones.available.names

  public_subnets = [
    for i in range(length(local.azs)) :
    cidrsubnet(var.cidr_block, 8, i)
  ]

  private_subnets = [
     for i in range(length(local.azs)):
     cidrsubnet(var.cidr_block, 8, i+length(local.azs))
  ]
}

#====================================
# Create Internt gateway (igw)
#====================================
resource "aws_internet_gateway" "igw" {
     vpc_id = var.vpc_id
}