locals {
  default_tags = {
    project_name = var.project_name
    Owner        = var.owner
    ManagedBy    = "terraform"
  }
}
