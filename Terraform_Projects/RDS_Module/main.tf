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
  source         = "./modules/rds"
  identifier     = "test-db"
  instance_class = "db.t3.micro"
  engine_version = "14.11"
  storage_size   = 15

  private_subnet_ids = module.networking.privte_subnet_id
  rds_sg_id          = [module.security.security_group_id]
  credential = {
    username = var.db_username
    password = var.db_password
  }
}
