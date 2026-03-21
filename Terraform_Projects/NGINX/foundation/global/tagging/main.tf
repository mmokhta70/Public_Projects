variable "environments" {
  type        = string
  description = "we will use this tag for our environments"
}

output "common_tag" {
  value = {
    Environment = var.environments
    Owner       = "https://www.linkedin.com/in/mmokhta"
    Mangedby    = "Terraform"
  }
}
