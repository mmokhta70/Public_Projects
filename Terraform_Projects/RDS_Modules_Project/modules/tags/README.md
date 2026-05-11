# Module: tags

Generates a standard tag map that is merged onto every AWS resource in the project. Call this module once at the root and pass its `common_tags` output to all other modules.

## Usage

```hcl
module "tags" {
  source       = "./modules/tags"
  environment  = "dev"
  project_name = "myapp"
  owner        = "platform-team"
  cost_center  = "CC-1234"
}

# Then pass to other modules:
# tags = module.tags.common_tags
```

## Inputs

| Name | Type | Default | Description |
|---|---|---|---|
| `environment` | string | — | `dev`, `staging`, or `prod` |
| `project_name` | string | — | Name of the project |
| `owner` | string | — | Owner of the resources |
| `cost_center` | string | — | Cost center code for billing |
| `extra_tags` | map(string) | `{}` | Additional tags merged on top of the standard set |

## Outputs

| Name | Description |
|---|---|
| `common_tags` | Merged map of all tags — pass this to every other module's `tags` input |

## Tag keys applied

| Key | Value |
|---|---|
| `Project_name` | `var.project_name` |
| `Environment` | `var.environment` |
| `Owner` | `var.owner` |
| `ManagedBy` | `"<environment>-team"` |
| `CostCenter` | `var.cost_center` |
| *(extra_tags keys)* | *(extra_tags values)* |