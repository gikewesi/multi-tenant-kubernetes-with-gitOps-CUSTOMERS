variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the cluster"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS cluster"
}

variable "cluster_role_policy_attachments" {
  description = "Dependencies for cluster IAM role policy attachments"
}
