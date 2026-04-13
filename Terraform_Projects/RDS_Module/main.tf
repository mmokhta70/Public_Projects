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
