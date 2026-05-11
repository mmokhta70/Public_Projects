#------------------- Fetch AZs Automatically from the main region we defined -------------------#

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
  project_name = var.project_name
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

#================== security module ==================#
module "security" {
  source       = "../../modules/security"
  vpc_id       = module.vpc.vpc_id
  environment  = "dev"
  project_name = var.project_name
  tags         = module.tags.common_tags
  ingress_config = [{
    from_port   = 5432
    to_port     = 5432
    cidr_block  = [module.vpc.vpc_cidr]
    description = "Allow internal DB access"
  }]
}

#================== RDS module ==================#
module "rds" {
  source = "../../modules/rds"

  #--------------- db config ---------------#
  identifier     = var.identifier
  db_name        = var.db_name
  instance_class = var.instance_class
  engine_version = "14"
  storage_size   = 15
  environment    = "dev"
  project_name   = var.project_name

  #--------------- credential ---------------#

  credential = {
    username = var.credential.username
    password = var.credential.password
  }

  #--------------- subnet config ---------------#

  private_subnet_ids = module.networking.private_subnet
  security_group_ids = [module.security.security_group_id]

  tags = module.tags.common_tags
}
