provider "aws" {
  region = var.main_region
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = var.cider_block
}


module "networking" {
  source         = "./modules/networking"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = var.cider_block
  azs            = var.azs
}


module "security" {
  source = "./modules/security"
  vpc_id = var.vpc_id
}


module "rds" {
  source = "./modules/rds"
  credential = {
    username = var.credentials.username
    password = var.credentials.password
  }
  private_subnet_ids = module.networking.private_subnet_id
  rds_sg_id          = module.networking.private_subnet_id
}
