resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true #required for RDS endpoint resolution
  enable_dns_support   = true #needed for internal AWS services
  project_name = var.project_name
  environment = var.environment
  tags = merge(var.tags, {
       Name = "${var.project_name}-${var.environment}_vpc"
  })
}
