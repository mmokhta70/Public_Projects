#------- this module contains subnets, IGw , NAT Gateway, Rotue table ------------#
#
#
#--------- create subnets ---------#
resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  for_each          = local.public_subnets
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
}


resource "aws_subnet" "private" {
  vpc_id = var.vpc_id
}
