
#----------------- global tagging for project -----------------#
locals {
  default_tags = {
    Environment  = var.environment
    project_name = var.project_name
    Owner        = var.owner
    ManagedBy    = "terraform"
  }
  financial_tags = {
    Costcentre = var.cost_centre
  }
  golbal_tags = merge(local.default_tags, local.financial_tags, var.extra_tags)
}
