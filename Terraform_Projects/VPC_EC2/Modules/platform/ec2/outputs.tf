#resource "aws_instance" "main"
output "instance_id" {
  value = aws_instance.main.id
}
