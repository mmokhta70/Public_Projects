#------------------------------------
# create public subnet
#------------------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  for_each          = local.puclic_subnets
  cidr_block        = each.value.cidr
  availability_zone = each.value.azs
  tags = {
    Name = each.key
    type = "public"
  }
}

#------------------------------------
# create pricvate subnet
#------------------------------------
resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  for_each          = local.private_subnets
  cidr_block        = each.value.cidr
  availability_zone = each.value.azs
  tags = {
    Name = each.key
    type = "private"
  }
}

#------------------------------------
# create Internet Gateway
#------------------------------------
resource "aws_internet_gateway" "Igw" {
  vpc_id = var.vpc_id
  count  = length(local.puclic_subnets) > 0 ? 1 : 0
}

#------------------------------------
# create nat Gateway
# 1. first we create a elastic IP address
# 2. allocate the elastic IP to the nat gateway
#------------------------------------
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.private_subnet)[0].id
  tags = {
    Name = "nat_gw"
  }
}

#------------------------------------
# create public route table
#------------------------------------
resource "aws_route_table" "pulic_rtb" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw[0].id
  }
}

#------------------------------------
# create private route table
#------------------------------------
resource "aws_route_table" "private_rtb" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
  }
}


#------------------------------------
# create public route table associate
#------------------------------------
resource "aws_route_table_association" "public_associate" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pulic_rtb.id
}



#------------------------------------
# create Private route table associate
#------------------------------------
resource "aws_route_table_association" "private_associate" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rtb.id
}
