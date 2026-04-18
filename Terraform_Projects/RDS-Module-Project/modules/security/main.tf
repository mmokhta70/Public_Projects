resource "aws_security_group" "this" {
  name        = local.name
  vpc_id      = var.vpc_id
  description = "this security group integrated with private subnets"
}
