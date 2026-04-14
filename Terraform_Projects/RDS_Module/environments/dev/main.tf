module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source = "./modules/networking"

  vpc_id               = module.vpc.vpc_id
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  region               = var.region
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"

  private_subnet_ids = module.networking.private_subnet_ids
  rds_sg_ids         = module.security.rds_sg_ids
  identifier         = var.identifier
}
