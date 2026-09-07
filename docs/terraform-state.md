# Terraform Remote State Strategy

Production environments should store Terraform state in a remote backend with encryption, restricted access, versioning, and locking.

## Azure pattern

Use an Azure Storage Account container with:
- private network access where possible
- RBAC instead of account keys
- blob versioning and soft delete
- separate state keys per environment

Example backend configuration:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-prod"
    storage_account_name = "stplatformtfstate"
    container_name       = "tfstate"
    key                  = "platform/prod.tfstate"
  }
}
```

## AWS pattern

Use S3 with encryption and versioning plus DynamoDB-compatible locking where the chosen Terraform workflow requires it.

State access should be treated as privileged because state can contain sensitive resource metadata.
