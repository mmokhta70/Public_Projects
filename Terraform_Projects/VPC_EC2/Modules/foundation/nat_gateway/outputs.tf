#resource "aws_nat_gateway" "main"
output "nat_gateay_" {
  value = aws_nat_gateway.main.id
}
