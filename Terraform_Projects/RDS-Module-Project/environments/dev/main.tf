
module "tags" {
  source       = "../../modules/tags"
  cost_centre  = var.cost_centre
  environment  = var.environment
  owner        = var.owner
  project_name = var.project_name

}
