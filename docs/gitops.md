# GitOps Delivery with Argo CD

Argo CD continuously reconciles the desired state stored in Git with the Kubernetes cluster.

## Operating model

1. Infrastructure is provisioned with Terraform.
2. Argo CD is bootstrapped into the cluster.
3. Application/platform configuration is reviewed through pull requests.
4. Argo CD detects the approved Git change and reconciles it.
5. Drift is visible and can be self-healed for explicitly managed resources.

Production environments should use separate Argo CD projects, scoped service accounts, protected branches, and explicit controls for high-impact changes.
