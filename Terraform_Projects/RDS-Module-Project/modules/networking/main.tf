
#------- this module contains subnets, IGw , NAT Gateway, Rotue table ------------#
#
#
#--------- create public subnets ---------#
resource "aws_subnet" "public" {
  for_each          = local.public_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = merge(var.tags, {
    Name = each.key
  })
}

#--------- create private subnets ---------#
resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = merge(var.tags, {
    Name = each.key
  })
}
