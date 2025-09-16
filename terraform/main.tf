terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

# VPC
module "vpc" {
  source   = "./modules/vpc"
  name     = "${var.project_name}-vpc"
  cidr     = var.vpc_cidr
}

module "subnets" {
  source        = "./modules/subnets"
  vpc_id        = module.vpc.vpc_id
  public_cidrs  = var.public_subnets
  private_cidrs = var.private_subnets
  azs           = var.azs
  name          = var.project_name
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = var.project_name
}

module "ngw" {
  source             = "./modules/ngw"
  public_subnet_ids  = module.subnets.public_subnet_ids
  name               = var.project_name
}
module "route_tables" {
  source            = "./modules/route-tables"
  vpc_id            = module.vpc.vpc_id
  name              = var.project_name
  igw_id            = module.igw.igw_id
  public_subnet_ids = {
    "az1" = module.subnets.public_subnet_ids[0]
    "az2" = module.subnets.public_subnet_ids[1]
  }
  private_subnet_ids = {
    "az1" = module.subnets.private_subnet_ids[0]
    "az2" = module.subnets.private_subnet_ids[1]
  }
  nat_gateway_ids = {
    "az1" = module.ngw.nat_gateway_ids[0]
    "az2" = module.ngw.nat_gateway_ids[1]
  }
}

module "tf_state_bucket" {
  source      = "./modules/s3"
  bucket_name = "${var.project_name}-tf-state"
}

module "eks_artifacts_bucket" {
  source      = "./modules/s3"
  bucket_name = "${var.project_name}-eks-artifacts"
}

module "terraform_lock" {
  source      = "./modules/dynamodb"
  table_name  = "${var.project_name}-tf-lock"
}

module "eks" {
  source = "./modules/eks"

  cluster_name                    = var.cluster_name
  cluster_role_arn                = module.iam.eks_cluster_role_arn
  private_subnet_ids              = module.subnets.private_subnet_ids
  cluster_role_policy_attachments = module.iam.cluster_role_policy_attachments
}

module "eks_infra_ng" {
  source = "./modules/node-groups"

  cluster_name                 = var.cluster_name
  node_group_name              = "${var.cluster_name}-infra-ng"
  node_role_arn                = module.iam.eks_node_role_arn
  private_subnet_ids           = module.subnets.private_subnet_ids
  desired_size                 = 2
  max_size                     = 3
  min_size                     = 1
  instance_types               = ["t3.medium"]
  node_role_policy_attachments = module.iam.node_role_policy_attachments
}

module "eks_app_ng" {
  source = "./modules/node-groups"

  cluster_name                 = var.cluster_name
  node_group_name              = "${var.cluster_name}-app-ng"
  node_role_arn                = module.iam.eks_node_role_arn
  private_subnet_ids           = module.subnets.private_subnet_ids
  desired_size                 = 3
  max_size                     = 6
  min_size                     = 2
  instance_types               = ["t3.large"]
  node_role_policy_attachments = module.iam.node_role_policy_attachments
}
module "iam" {
  source = "./modules/iam"

  cluster_name      = var.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
}

module "alb" {
  source       = "./modules/alb"
  cluster_name       = module.eks.cluster_name
  region             = var.aws_region
  vpc_id             = module.vpc.vpc_id
  oidc_provider_arn  = module.iam.oidc_provider_arn
  oidc_provider_url  = module.iam.oidc_provider_url
  chart_version      = var.alb_chart_version
  alb_role_arn       = module.iam.alb_controller_irsa_role_arn
  alb_sg_id          = module.sgs.alb_sg_id
}

module "ecr" {
  source          = "./modules/ecr"
  }

module "argocd" {
  source            = "./modules/argocd"
  argocd_role_arn   = module.iam.argocd_irsa_role_arn
}

module "sgs" {
  source = "./modules/security-groups"

  cluster_name         = var.cluster_name
  vpc_id               = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
}