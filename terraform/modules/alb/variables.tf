variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}

variable "chart_version" {
  type    = string
  default = "1.8.1" # example, adjust to latest stable
}
variable "alb_role_arn" {
  description = "IAM role ARN for the AWS Load Balancer Controller service account"
  type        = string
}
variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
}
