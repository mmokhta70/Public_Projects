terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "tags" {
  source       = "./modules/tags"
  environment  = var.environment
  project_name = var.project_name
  owner        = var.owner
  cost_center  = var.cost_center
  extra_tags   = var.extra_tags
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment
  tags         = module.tags.common_tags
}

module "networking" {
  source       = "./modules/networking"
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
  azs          = var.azs
  project_name = var.project_name
  environment  = var.environment
  tags         = module.tags.common_tags
}

module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id
  db_port      = var.db_port
  project_name = var.project_name
  environment  = var.environment
  tags         = module.tags.common_tags
}