#--------- Public subnets id ---------#
output "public_subnet" {
  value = [for i in aws_subnet.public : i.id]
}

#--------- Private subnets id ---------#
output "private_subnet" {
  value = [for i in aws_subnet.private : i.id]
}
