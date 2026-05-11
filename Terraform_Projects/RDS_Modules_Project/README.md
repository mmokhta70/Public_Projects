# RDS Modules Project

Terraform infrastructure for the AWS networking and security layer required to host an RDS database. The project is split into focused, reusable modules that can be composed together.

## Architecture

```
root
├── tags        — standard tag set applied to every resource
├── vpc         — VPC with DNS support enabled
├── networking  — public/private subnets, internet gateway, route tables, DB subnet group
└── security    — app-tier and RDS security groups
```

The RDS instance itself is not created here — this project provisions the network it needs. Pass the outputs (`db_subnet_group_name`, `rds_security_group_id`) to your RDS module or resource.

## Prerequisites

- Terraform >= 1.5.0
- AWS provider ~> 5.0
- AWS credentials configured (via environment variables, `~/.aws/credentials`, or an IAM role)

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your values.
2. Run:

```bash
terraform init
terraform plan
terraform apply
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `aws_region` | string | `"us-east-1"` | AWS region to deploy into |
| `environment` | string | — | `dev`, `staging`, or `prod` |
| `project_name` | string | — | Prefix used in all resource names |
| `owner` | string | — | Owner tag value |
| `cost_center` | string | — | Cost center code for billing |
| `extra_tags` | map(string) | `{}` | Additional tags merged on top of the standard set |
| `vpc_cidr` | string | — | VPC CIDR block (RFC 1918 private range) |
| `public_subnet_cidrs` | list(string) | — | One public subnet CIDR per AZ |
| `private_subnet_cidrs` | list(string) | — | One private subnet CIDR per AZ (used for RDS) |
| `availability_zones` | list(string) | — | AZs matching the subnet CIDR lists |
| `db_port` | number | `5432` | DB port (5432 PostgreSQL, 3306 MySQL) |

## Outputs

| Name | Description |
|---|---|
| `vpc_id` | ID of the created VPC |
| `public_subnet_ids` | IDs of the public subnets |
| `private_subnet_ids` | IDs of the private subnets |
| `db_subnet_group_name` | DB subnet group name — pass this to your RDS resource |
| `rds_security_group_id` | RDS security group ID — pass this to your RDS resource |
| `app_security_group_id` | App tier security group ID |

## Example `terraform.tfvars`

```hcl
aws_region   = "us-east-1"
environment  = "dev"
project_name = "myapp"
owner        = "platform-team"
cost_center  = "CC-1234"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

db_port = 5432
```

## Security notes

- The RDS security group only accepts inbound traffic on `db_port` from the app security group — no public access.
- Private subnets have no route to the internet gateway, isolating the DB tier.
- For production, consider enabling VPC Flow Logs and setting `deletion_protection = true` on your RDS instance.
- Never commit `*.tfvars` files — they are gitignored. Use a secrets manager or CI/CD secret injection for production credentials.
