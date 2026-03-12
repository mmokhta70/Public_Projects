#resource "aws_subnet" "main"
output "subnet_id" {
  #value = aws_type.name.id
  value = aws_subnet.main.id
}
