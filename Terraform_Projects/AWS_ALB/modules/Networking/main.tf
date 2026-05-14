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
     tags = merge (var.common_tags , {
          Name = "£{var.project_name}-${var.environment}-igw"
     })
}


#====================================
# Create public subnet
#====================================
resource "aws_subnet" "public_subnet" {
     vpc_id = var.vpc_id
     count = length(local.public_subnets)
     cidr_block = local.public_subnets[count.index]
     availability_zone = local.azs[count.index]
     map_public_ip_on_launch = true

     tags = merge (var.common_tags , {
          Name = "£{var.project_name}-${var.environment}-public-subnet-${local.azs[count.index]}"
     })

}