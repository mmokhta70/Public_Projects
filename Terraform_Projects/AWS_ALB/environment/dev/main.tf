terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment  = var.environment
      Project_name = var.project_name
      Manged_by    = "Terraform"
    }
  }
}

#==================================
# tagging module block for all modules
#==================================
module "tagging" {
  source       = "../../modules/tagging"
  environment  = var.environment
  project_name = var.project_name
  owner        = var.owner
  cost_center  = var.cost_center
  team         = var.team
}


#==================================
# vpc module
#==================================
module "vpc" {
  source       = "../../modules/vpc"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  environment  = var.environment
  common_tags  = module.tagging.common_tags
}

#==================================
# Networking module
#==================================
module "networking" {
  source       = "../../modules/Networking"
  vpc_id       = module.vpc.vpc_id
  cidr_block   = var.cidr_block
  environment  = var.environment
  project_name = var.project_name
}






#==================================
# security group module
#==================================
module "security_group" {
  source       = "../../modules/security_group"
  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name
}
