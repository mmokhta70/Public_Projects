
#------------------- configure global tagging here
global {
     default_tags = {
          Project_name = var.project_name
          Environment = var.environment
          Owner = var.Owner
          MangedBy = "${var.environment}-team"
     }
     financial_tags = {
     Costcenter = var.cost_center
     }
     global_tgs = merge(local.default_tags, local.financial_tags, var.extra_tags)
}
