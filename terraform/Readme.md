# Terraform – Multi-Tenant EKS Platform

## Overview

Terraform provisions the infrastructure foundation for a **multi-tenant Kubernetes platform**:

* **Networking**: VPC with private subnets, route tables, NAT gateway
* **EKS Cluster**: Control plane + node groups / Fargate profiles
* **IAM / IRSA**: Roles for GitOps, Prometheus, Policy Reporter, and Secrets Manager access
* **Security Groups**: EKS nodes + internal ALB
* **AWS Load Balancer Controller**: Internal ALB for Policy Reporter UI
* **Optional Logging**: CloudWatch log groups for EKS

All workloads, Kyverno policies, and Policy Reporter UI are deployed via **GitOps** (Argo CD).

---

## Prerequisites

* AWS CLI configured
* Terraform v1.5+
* kubectl installed

---

## Quick Start

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

* **Outputs**:

  * `cluster_name`
  * `kubeconfig_path`
  * `alb_security_group_id`
  * IRSA role ARNs for GitOps / monitoring / secrets

---

## Access Internal Services

* Policy Reporter UI runs behind an **internal ALB**:

  ```
  http://<alb-private-dns>
  ```
* Accessible only from within your VPC.

---

## Notes

* **No ACM or public Route 53** used.
* All applications, Helm charts, Prometheus/Grafana dashboards, and Kyverno policies are deployed via GitOps.
* Terraform handles **infrastructure only**; all apps live in GitOps manifests.
