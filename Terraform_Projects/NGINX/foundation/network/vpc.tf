variable "vpc_cidr_block" {
  default = "50.0.0.0/16"
}

variable "public_subnets" {
  description = "list of all the avaailable subnet"
  type        = list(string)
  default     = ["50.0.1.0/24", "50.0.2.0/24"]
}

module "global_tagging" {
  source       = "../tagging"
  environments = "prod"
  owner        = "devops"
  project_name = "nginx"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = merge(module.gobla_taggin.common_tags, {
    Name = "main_vpc"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(module.global_tags.common_tags, {
    Name = "main_internt_gateway"
  })
}

resource "aws_subnet" "public_subnet_reachable" {
  for_each                = toset(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = merge(module.global_tagging.common_tags, {
    Name = "public_subnet_for_reachability"
    Tier = "public"
  })
}


output "vpc_id" {
  value = aws_vpc.main.id
}
