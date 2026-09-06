# Production Kubernetes Platform with Terraform

Production-oriented reference platform for provisioning and operating Kubernetes on Azure Kubernetes Service (AKS) using Terraform, Helm, policy controls, workload identity, and GitHub Actions.

## What this demonstrates

- Reusable Terraform modules for network, AKS, identities, and observability
- Private-cluster-ready architecture with least-privilege access patterns
- Azure Key Vault integration through workload identity
- Environment separation for dev, stage, and prod
- Policy, autoscaling, monitoring, and platform add-ons
- CI checks for Terraform formatting, validation, linting, and security scanning
- Operational runbooks for common SRE scenarios

## Architecture

```text
GitHub Actions
      |
      v
Terraform ----> Azure Resource Group
                  |
                  +--> VNet / Subnets
                  |
                  +--> AKS
                  |     |
                  |     +--> System Node Pool
                  |     +--> User Node Pool
                  |     +--> OIDC / Workload Identity
                  |
                  +--> Log Analytics
                  |
                  +--> Key Vault
```

## Repository layout

```
.
├── .github/workflows/
├── environments/
│   ├── dev/
│   └── prod/
├── modules/
│   ├── aks/
│   └── network/
├── policies/
├── runbooks/
└── README.md
```

## Engineering decisions

The platform separates reusable modules from environment composition so teams can promote infrastructure changes without copying resource definitions. AKS uses managed identity and OIDC workload identity instead of embedded credentials. Network configuration is explicit and designed to support private networking patterns. Observability is integrated at provisioning time rather than added as an afterthought.

## CI/CD

Pull requests run Terraform formatting and validation checks. The workflow is structured so plan/apply stages can be protected with GitHub Environments and cloud federation instead of long-lived secrets.

## Usage

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

For production use, configure a remote backend, federated GitHub identity, branch protection, required reviewers, and environment-specific policy gates.

## SRE scenarios covered

- Node pool scaling and capacity review
- Failed deployment triage
- AKS control-plane and node observability
- Secret access through Key Vault workload identity
- Terraform drift detection and recovery

## Status

This repository is designed as a portfolio-grade platform engineering reference implementation. It intentionally focuses on maintainability, operability, and production patterns rather than a single-click demo.
