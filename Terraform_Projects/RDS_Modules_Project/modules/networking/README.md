# Module: networking

Creates the subnet layout, routing, and DB subnet group needed for an RDS deployment.

**Resources created:**
- Public subnets (one per AZ) with `map_public_ip_on_launch = true`
- Private subnets (one per AZ) — isolated from the internet, used for RDS
- Internet gateway attached to the VPC
- Public route table with a default route to the internet gateway
- Route table associations for all public subnets
- `aws_db_subnet_group` spanning the private subnets — required by RDS for Multi-AZ support

## Usage

```hcl
module "networking" {
  source               = "./modules/networking"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  project_name         = "myapp"
  environment          = "dev"
  tags                 = module.tags.common_tags
}
```

## Inputs

| Name | Type | Description |
|---|---|---|
| `vpc_id` | string | ID of the VPC (from the vpc module) |
| `public_subnet_cidrs` | list(string) | One CIDR per AZ for public subnets |
| `private_subnet_cidrs` | list(string) | One CIDR per AZ for private/RDS subnets |
| `availability_zones` | list(string) | AZs — length must match both CIDR lists |
| `project_name` | string | Project name for resource naming |
| `environment` | string | Deployment environment for resource naming |
| `tags` | map(string) | Common tags from the tags module |

## Outputs

| Name | Description |
|---|---|
| `public_subnet_ids` | IDs of the public subnets |
| `private_subnet_ids` | IDs of the private subnets |
| `db_subnet_group_name` | DB subnet group name — pass this to your `aws_db_instance` |
| `internet_gateway_id` | ID of the internet gateway |

## Notes

- Private subnets have no route to the internet gateway, keeping the DB tier isolated.
- At least two AZs (and therefore two private subnets) are recommended to satisfy RDS Multi-AZ requirements.