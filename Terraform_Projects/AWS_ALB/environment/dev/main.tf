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

module "tagging" {
  source       = "../../modules/tagging"
  environment  = var.environment
  project_name = var.project_name
  owner        = var.owner
  cost_center  = var.cost_center
  team         = var.team
}
