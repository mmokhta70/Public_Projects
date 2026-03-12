#resource "aws_internet_gateway" "main"
output "name" {
  value = aws_internet_gateway.main.id
}
