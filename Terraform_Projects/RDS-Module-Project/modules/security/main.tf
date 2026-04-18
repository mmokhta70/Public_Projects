resource "aws_security_group" "this" {
  name        = local.name
  vpc_id      = var.vpc_id
  description = "this security group integrated with private subnets"

  #================= dynamic ingress =================#
  dynamic "ingress" {
    for_each = var.ingress_config

    content {
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
      protocol  = "tcp"

      cidr_blocks = length(ingress.value.cidr_block) > 0 ? ingress.value.cidr_block : null

      security_groups = length(ingress.value.security_groups) > 0 ? ingress.value.security_groups : null

      description = ingress.value.description
    }
  }

  #================= egress =================#
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name      = local.name
    Component = "rds"
  })
}
