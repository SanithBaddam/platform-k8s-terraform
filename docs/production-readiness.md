# Production Readiness Checklist

## Reliability
- Multi-zone node pools where the region supports them
- Pod disruption budgets for critical services
- Requests/limits and autoscaling tested under load
- Backup/restore procedures exercised
- Upgrade and rollback procedures documented

## Security
- OIDC/workload identity instead of static credentials
- Private secret stores and short-lived access
- Network policies and controlled egress
- Image and IaC scanning in CI
- RBAC aligned to least privilege

## Operations
- SLOs and alert ownership defined
- Runbooks linked from paging alerts
- Terraform state uses remote locking and restricted access
- Platform changes require reviewed pull requests
- Production applies use protected environments and approvals
