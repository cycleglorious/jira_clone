output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_name" {
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_managed_node_groups" {
  value       = module.eks.eks_managed_node_groups
}

output "cloudwatch_log_group_name" {
  value       = "/aws/eks/${local.cluster_name}/cluster" # Стандартна назва групи логів для addon'а
}

output "cluster_security_group_id" {
  value       = module.eks.cluster_primary_security_group_id
}