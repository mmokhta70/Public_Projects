resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true #required for RDS endpoint resolution
  enable_dns_support   = true #needed for internal AWS services

  tags = merge(var.tags, {
    Name = "main_vpc"
  })
}
