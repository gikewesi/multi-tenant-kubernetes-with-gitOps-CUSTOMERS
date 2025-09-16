output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "argocd_irsa_role_arn" {
  value = aws_iam_role.argocd_irsa.arn
}

output "alb_controller_irsa_role_arn" {
  value = aws_iam_role.alb_controller_irsa.arn
}
output "cluster_role_policy_attachments" {
  value = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy.id,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy.id
  ]
}

# Node role policy attachments
output "node_role_policy_attachments" {
  value = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy.id,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy.id,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly.id
  ]
}

# OIDC provider ARN and URL (just passing variables through)
output "oidc_provider_arn" {
  value = var.oidc_provider_arn
}

output "oidc_provider_url" {
  value = var.oidc_provider_url
}
