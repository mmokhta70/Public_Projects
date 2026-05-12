
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  subnet_id     = var.subnet_id
  allocation_id = aws_eip.nat.id
  tags = {
    Name = "nat-gateway"
  }
}
