variable "environmet" {
  type        = string
  description = "we will use this tag for our environments"
}

output "common_tag" {
  value = {
    Environment = var.environmet
    Owner       = "https://www.linkedin.com/in/mmokhta"
    Mangedby    = "Terraform"
  }
}
