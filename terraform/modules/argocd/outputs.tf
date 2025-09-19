output "argocd_server_url" {
  value = try(
    helm_release.argocd.status, 
    "pending"
  )
}
