variable "vpc_cidr_block" {
  default = "50.0.0.0/16"
}

variable "public_subnet" {
  description = "list of all the avaailable subnet"
  type        = list(string)
  default     = ["50.0.1.0/24", "50.0.2.0/24"]
}

module "global_tagging" {
  source       = "../tagging"
  environments = "prod"
  owner        = "devops"
  project_name = "nginx"
  tags = merge(mdoule.global_tagging.common_global_tags, {
    Name = "main_vpc"
  })
}
