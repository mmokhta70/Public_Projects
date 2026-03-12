module "vpc" {
  source     = "../../foundation/vpc"
  cidr_block = "50.0.0.0/0"
  vpc_name   = "dev_vpc"
}

module "public_subnet" {
  source      = "../../foundation/subnet"
  vpc_id      = module.vpc.vpc_id
  cidr_block  = "50.1.1.0/24"
  az          = "eu-west-2"
  subnet_name = "public_subnet_Intearnet_access"
}
