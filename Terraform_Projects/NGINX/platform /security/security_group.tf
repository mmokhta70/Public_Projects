variable "vpc_id" {}
module "globale_taggin" {
  source       = "../../foundation/global/tagging"
  environments = "prod"
  owner        = "devops"
  project_name = "nginx"
}


resource "aws_security_group" "sg_ec2_nginx" {
  name   = "security_group_nginx"
  vpc_id = var.vpc_id

  #ingress for port 80 - HTTP
  ingress {
    from_port   = local.allowed_port[0]
    to_port     = local.allowed_port[0]
    protocol    = "tcp"
    cidr_blocks = local.cider_block
  }

  #ingress for port 443 - HTTPS
  ingress {
    from_port   = local.allowed_port[1]
    to_port     = local.allowed_port[1]
    protocol    = "tcp"
    cidr_blocks = local.cider_block
  }
  tags = merge(module.globale_taggin.common_global_tags, {
    Name = "security_nginx"
  })
}

output "sg_nginx" {
  value = aws_security_group.sg_ec2_nginx.id
}
