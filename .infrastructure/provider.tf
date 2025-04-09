terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region              = var.region
  shared_config_files = ["~/.aws/credentials"]
}

data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token = var.vault_token
}

data "vault_generic_secret" "database" {
  path = "secret/jira-clone/database"
}

data "vault_generic_secret" "upstash" {
  path = "secret/jira-clone/upstash"
}

data "vault_generic_secret" "clerk" {
  path = "secret/jira-clone/clerk"
}
