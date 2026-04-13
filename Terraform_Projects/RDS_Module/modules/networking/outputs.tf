output "public_subnet_id" {
  value = [for s in aws_subnet.puclic_subnets : s.id]
}


output "privte_subnet_id" {
  value = [for s in aws_subnet.private_subnets : s.id]
}
