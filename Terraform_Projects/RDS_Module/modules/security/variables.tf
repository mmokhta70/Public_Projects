locals {
  common_tags = {
    owner      = "mehrdad. mokhtari1370@gmail.com"
    managed_by = "terraform"
  }
  ingress_config = {
    from_port  = 5432
    to_port    = 5432
    cidr_block = ["10.0.0.0/16"]
  }
}

variable "vpc_id" {}
