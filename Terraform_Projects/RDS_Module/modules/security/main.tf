resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = local.ingress_config.from_port
    to_port     = local.ingress_config.to_port
    protocol    = "tcp"
    cidr_blocks = local.ingress_config.cidr_block
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "rds_sg_db"
  })
}
