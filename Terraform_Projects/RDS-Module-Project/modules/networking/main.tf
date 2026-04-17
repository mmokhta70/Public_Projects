
#------- this module contains subnets, IGw , NAT Gateway, Rotue table ------------#
#
#
#--------- public subnets ---------#
resource "aws_subnet" "public" {
  for_each          = local.public_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = merge(var.tags, {
    Name = each.key
  })
}

#--------- private subnets ---------#
resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = merge(var.tags, {
    Name = each.key
  })
}

#--------- Public access indculde igw, route table, route tabel association ---------#
#
#--------- IGW ---------#
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = merge(var.tags, {
    Name = "igw"
  })
}

#--------- ROUTE TABLE ---------#
resource "aws_route_table" "public_rtb" {
  vpc_id = var.vpc_id
}


#--------- ROUTE ---------#
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


#--------- ROUTE TABLE ASSOCIATION ---------#
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rtb.id
}

#--------- Private access indculde NAT Gateway, Elastic IP ,route table, route table association ---------#
#
#--------- create Elastic IP assress Per az

resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  domain   = "vpc"
  tags = merge(var.tags, {
    Name = "nat-eip-${each.key}"
  })
}
#--------- create NAT gateway per az
resource "aws_nat_gateway" "this" {
  for_each      = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  tags = merge(var.tags, {
    Name = "nat-${each.key}"
  })
}

#------------ Create Route table per private subnet ------------#
resource "aws_route_table" "private_rtb" {
  for_each = aws_subnet.private
  vpc_id   = var.vpc_id

  tags = merge(var.tags, {
    Name = "private-rtb-${each.key}"
  })
}

#------------ Creat Route to NAT ------------#
resource "aws_route" "private-nat" {
  for_each               = aws_subnet.private
  route_table_id         = aws_route_table.private_rtb[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this["public-${each.value.availability_zone}"].id
}

#------------ Associate Private Subnets ------------#
resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rtb[each.key].id
}
