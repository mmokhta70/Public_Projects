#--------- Public subnets id  ---------#
output "public_subnet" {
  value = [for i in aaws_subnet.public : i.id]
}

#--------- Private subnets id  ---------#
output "private_subnet" {
  value = [for i in aaws_subnet.private : i.id]
}
