# Module: security

Creates two security groups that enforce network-level separation between the application tier and the RDS database.

**Resources created:**
- `app-sg` — applied to EC2 instances / ECS tasks in the app tier; allows all outbound traffic
- `rds-sg` — applied to the RDS instance; only allows inbound traffic on `db_port` from `app-sg`; no public access

## Usage

```hcl
module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id
  db_port      = 5432
  project_name = "myapp"
  environment  = "dev"
  tags         = module.tags.common_tags
}
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `vpc_id` | string | — | ID of the VPC (from the vpc module) |
| `db_port` | number | — | Port the database listens on. Validated to be 1–65535. |
| `project_name` | string | — | Project name for resource naming |
| `environment` | string | — | Deployment environment for resource naming |
| `tags` | map(string) | — | Common tags from the tags module |

## Outputs

| Name | Description |
|---|---|
| `app_security_group_id` | ID of the app tier security group — attach to EC2/ECS/Lambda |
| `rds_security_group_id` | ID of the RDS security group — pass to your `aws_db_instance` |

## Security model

```
Internet → (blocked) → rds-sg
App tier (app-sg) → port db_port → rds-sg
```

The RDS security group has no inbound rule for `0.0.0.0/0` — the only allowed source is the app security group ID. This ensures the database is never publicly reachable even if a subnet is misconfigured.