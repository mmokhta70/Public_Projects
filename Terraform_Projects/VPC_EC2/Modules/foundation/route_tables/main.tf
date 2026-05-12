resource "aws_route_table" "main" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.main.id
}
