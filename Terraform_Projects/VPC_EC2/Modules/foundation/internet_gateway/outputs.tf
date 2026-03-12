#resource "aws_internet_gateway" "main"
output "igw_id" {
  value = aws_internet_gateway.main.id
}
