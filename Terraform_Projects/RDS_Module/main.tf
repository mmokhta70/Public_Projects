provider "aws" {
  region = var.main_region
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = var.cider_block
}
