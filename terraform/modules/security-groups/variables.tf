variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for SGs"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for ALB access"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all SGs"
  default     = {}
}
