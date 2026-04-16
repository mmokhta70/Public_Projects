
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.cidr_block
  tags       = module.tags.common_tags
}


module "tags" {
  source       = "./modules/tags"
  cost_centre  = "asd-123"
  owner        = "Mehrdad.Mokhtari1370@gmail.com"
  environment  = "dev"
  project_name = "rds-module"
}
