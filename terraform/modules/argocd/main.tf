resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# Service Account with IRSA
resource "kubernetes_service_account" "argocd_sa" {
  metadata {
    name      = "argocd-server"
    namespace = kubernetes_namespace.argocd.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = var.argocd_role_arn
    }
  }
}

# Helm Release for ArgoCD
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  set = [
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    },
    {
      name  = "configs.cm.server.insecure"
      value = "true"
    },
    # Tell Helm to use our pre-created service account
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = kubernetes_service_account.argocd_sa.metadata[0].name
    }
  ]
}
