locals {
  default_tags = {
    Project_name = var.project_name
    Environment  = var.environment
    Owner        = var.owner
    ManagedBy    = "${var.environment}-team"
  }

  financial_tags = {
    CostCenter = var.cost_center
  }

  global_tags = merge(local.default_tags, local.financial_tags, var.extra_tags)
}