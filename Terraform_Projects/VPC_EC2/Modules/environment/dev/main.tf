#I didn't upload the terraform.tfvars as it contains secrets
module "vpc" {
  source     = "../../foundation/vpc"
  cidr_block = var.vpc_cidr
  vpc_name   = "dev_vpc"
}

module "public_subnet" {
  source            = "../../foundation/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone
  subnet_name       = "public_subnet_internet_access"
}

module "internet_gateway" {
  source = "../../foundation/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "public_route_table" {
  source     = "../../foundation/route_tables"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.internet_gateway.igw_id
  subnet_id  = module.public_subnet.subnet_id
}

module "nat_gateway" {
  source    = "../../foundation/nat_gateway"
  subnet_id = module.public_subnet.subnet_id
}

module "ec2" {
  source        = "../../platform/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  instance_name = var.instance_name
  subnet_id     = module.public_subnet.subnet_id
}
