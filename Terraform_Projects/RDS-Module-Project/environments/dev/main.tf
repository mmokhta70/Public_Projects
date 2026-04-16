
module "tags" {
  source       = "../../modules/tags"
  cost_centre  = "123-as"
  environment  = "dev"
  owner        = "dev-team"
  project_name = "RDS-Module"
}


module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = var.cidr_block
  tags       = module.tags.common_tags
}
