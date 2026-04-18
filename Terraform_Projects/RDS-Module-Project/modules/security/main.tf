resource "aws_security_group" "this" {
  name        = local.name
  vpc_id      = var.vpc_id
  description = "this security group integrated with private subnets"

  #================= create dynamic ingress rules =================#
  dynamic "ingress_rules" {
    for_each = var.ingress_config
    content = {
      from_port = each.value.from_port
      to_port   = each.value.to_port
      protocol  = "tcp"
      #================= Check if cidr_blocK exist or not
      cidr_block = length(ingress_rules.value.cidr_block) > 0 ? ingress_rules.value.cidr_block : null
      #================= Check if security_groups exist or not
      security_groups = legnth(ingress_rules.value.security_groups) > 0 ? ingress_rules.value.security_groups : null
    }

    #================= define egress rules
    egress {
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = ["0.0.0.0/0"]
    }

  }
  tags = merge(var.tags, {
    Name      = local.name
    Component = "rds"
  })
}
