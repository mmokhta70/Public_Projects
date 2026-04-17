
data "aws_availability_zones" "available" {

}
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}


#------------------- tags module - Environmetn level -------------------#
module "tags" {
  source       = "../../modules/tags"
  cost_centre  = "123-as"
  environment  = "dev"
  owner        = "dev-team"
  project_name = "RDS-Module"
}

#------------------- VPC module - Environmetn level -------------------#
module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = var.cidr_block
  tags       = module.tags.common_tags
}


#------------------- Networking module - Environmetn level -------------------#
module "networking" {
  source   = "../../modules/networking"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
  azs      = local.azs
  tags     = module.tags.common_tags
}
