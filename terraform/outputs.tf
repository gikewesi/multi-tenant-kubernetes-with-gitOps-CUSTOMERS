output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC created by the VPC module"
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "igw_id" {
  value = module.igw.igw_id
}

output "nat_gateway_ids" {
  value = module.ngw.nat_gateway_ids
}

output "public_route_table_id" {
  value = module.route_tables.public_route_table_id
}

output "private_route_table_ids" {
  value = module.route_tables.private_route_table_ids
}
output "tf_state_bucket_id" {
  value = module.tf_state_bucket.bucket_id
}

output "eks_artifacts_bucket_id" {
  value = module.eks_artifacts_bucket.bucket_id
}

output "terraform_lock_table" {
  value = module.terraform_lock.table_name
}

output "eks_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}

output "eks_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS cluster API"
}

output "eks_certificate_authority" {
  value       = module.eks.cluster_certificate_authority
  description = "The EKS cluster CA data"
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.eks.oidc_provider_url
}
output "eks_infra_ng_node_group_name" {
  value       = module.eks_infra_ng.node_group_name
  description = "The name of the infra node group"
}
output "node_group_name" {
  value       = module.eks_app_ng.node_group_name
  description = "The name of the app node group"
}

output "eks_cluster_role_arn" {
  value = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.iam.eks_node_role_arn
}


output "argocd_irsa_role_arn" {
  value = module.iam.argocd_irsa_role_arn
}

output "alb_controller_irsa_role_arn" {
  value = module.iam.alb_controller_irsa_role_arn
}
output "ecr_demo_app_url" {
  value = module.ecr.ecr_demo_app_url
}
output "argocd_server_url" {
  description = "The ArgoCD server URL"
  value       = module.argocd.argocd_server_url
}
output "alb_sg_id" {
  value = module.sgs.alb_sg_id
}