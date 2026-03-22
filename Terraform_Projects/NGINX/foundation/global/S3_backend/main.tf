provider "aws" {
  region = "eu-west-2"
}

module "globale_tagging" {
  source       = "../tagging"
  environments = "prod"
  owner        = "devops"
  project_name = "nginx"
}

resource "aws_s3_bucket" "terraform_s3_state" {
  bucket = "terraform-state"
  tags = merge(module.globale_tagging.common_global_tags, {
    Name = "Terraform_state"
  })
  lifecycle {
    prevent_destroy = true
  }
}
