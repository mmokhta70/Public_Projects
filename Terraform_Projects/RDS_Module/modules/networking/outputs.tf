output "public_subnet_id" {
  value = [for s in aws_subnet.public_subnet : s.id]
}


output "privte_subnet_id" {
  value = [for s in asw_subnet.aws_subnet.private_subnet : s.id]
}
