#------------------- Fetch AZs automatically from the configured region -------------------#

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

#------------------- Tags module -------------------#

module "tags" {
  source       = "../../modules/tags"
  environment  = "dev"
  project_name = var.project_name
  owner        = var.owner
  cost_center  = var.cost_center
  extra_tags   = var.extra_tags
}

#------------------- VPC module -------------------#

module "vpc" {
  source       = "../../modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  environment  = "dev"
  tags         = module.tags.common_tags
}

#------------------- Networking module -------------------#

module "networking" {
  source               = "../../modules/networking"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = local.azs
  project_name         = var.project_name
  environment          = "dev"
  tags                 = module.tags.common_tags
}

#------------------- Security module -------------------#

module "security" {
  source       = "../../modules/security"
  vpc_id       = module.vpc.vpc_id
  db_port      = var.db_port
  project_name = var.project_name
  environment  = "dev"
  tags         = module.tags.common_tags
}

# TODO: add module "rds" once modules/rds is created
