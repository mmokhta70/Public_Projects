resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  #required for RDS endpoint resolution
  enable_dns_support = true
  #needed for internal AWS services
  enable_dns_hostnames = true
  tags = {
    Name = "rds_vpc"
  }
}
