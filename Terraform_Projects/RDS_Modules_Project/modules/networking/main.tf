locals {
  public_subnets = {
    for i, az in var.azs :
    "public-${az}" => {
      cidr = cidrsubnet(var.vpc_cidr, 8, i)
      az   = az
    }
  }

  private_subnets = {
    for i, az in var.azs :
    "private-${az}" => {
      cidr = cidrsubnet(var.vpc_cidr, 8, i + length(var.azs))
      az   = az
    }
  }
}

resource "aws_subnet" "public" {
  for_each                = local.public_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Type = "public"
  })
}

resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Type = "private"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-igw"
  })
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = [for s in aws_subnet.private : s.id]

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  })
}
