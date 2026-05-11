# Module: vpc

Creates the AWS VPC with DNS hostname and DNS resolution support enabled — both are required for RDS endpoint resolution to work correctly.

## Usage

```hcl
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  project_name = "myapp"
  environment  = "dev"
  tags         = module.tags.common_tags
}
```

## Inputs

| Name | Type | Description |
|---|---|---|
| `vpc_cidr` | string | CIDR block for the VPC. Must be a valid RFC 1918 private range (`10.x`, `172.16-31.x`, or `192.168.x`). Validated at plan time. |
| `project_name` | string | Project name used in the VPC `Name` tag |
| `environment` | string | Deployment environment used in the VPC `Name` tag |
| `tags` | map(string) | Common tags from the tags module |

## Outputs

| Name | Description |
|---|---|
| `vpc_id` | ID of the created VPC — passed to networking and security modules |
| `vpc_cidr_block` | CIDR block of the VPC |