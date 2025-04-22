provider "aws" {
  region = var.aws_region
}

locals {
  cluster_name = var.cluster_name
  tags         = var.tags
  app_name     = var.app_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    attach_policy_arns = [
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ]
  }

  eks_managed_node_groups = {
    "${local.app_name}" = {
      node_group_name = local.app_name
      instance_types  = var.node_instance_types
      capacity_type   = "SPOT"

      min_size     = var.node_group_min_size
      max_size     = var.node_group_max_size
      desired_size = var.node_group_desired_size

      subnet_ids = var.private_subnet_ids

      attach_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

      labels = {
        role = "general-purpose"
        app  = local.app_name
      }

      tags = merge(local.tags, {
        "Name" = "${local.cluster_name}-${local.app_name}-node"
      })
    }
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  tags = local.tags
}


data "aws_iam_policy" "cloudwatch_agent" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role" "cloudwatch_role" {
  name = "${local.cluster_name}-cloudwatch-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = module.eks.oidc_provider_arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${module.eks.oidc_provider}:sub" = "system:serviceaccount:amazon-cloudwatch:cloudwatch-agent"
          }
        }
      }
    ]
  })


  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attach" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = data.aws_iam_policy.cloudwatch_agent.arn
}


resource "aws_eks_addon" "cloudwatch" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "amazon-cloudwatch-observability"
  service_account_role_arn    = aws_iam_role.cloudwatch_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}
