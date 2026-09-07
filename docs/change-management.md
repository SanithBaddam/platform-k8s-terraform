# Infrastructure Change Management

Infrastructure changes should follow a reviewed pull request workflow.

## Recommended flow

1. Open a feature branch.
2. Run formatting, validation, linting, and policy checks.
3. Generate a Terraform plan in CI.
4. Review blast radius and security implications.
5. Require approval for production.
6. Apply using short-lived workload identity.
7. Verify health and drift after deployment.

Avoid direct production changes outside the declared IaC workflow unless handling an emergency. Emergency changes should be reconciled back into Terraform immediately afterward.
