terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region              = var.region
  shared_config_files = ["~/.aws/credentials"]
}


provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}


# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
#   }
# }


provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = var.vault_token
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
