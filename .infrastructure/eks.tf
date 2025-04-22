module "eks_jira_clone" {
  source = "./modules/eks_jira_clone"

  aws_region         = var.region
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  app_name = local.app_name
}

resource "aws_eks_access_entry" "codebuild_access_app" {
  cluster_name  = module.eks_jira_clone.cluster_name
  principal_arn = module.codebuild_app_charts_deploy.codebuild_role.arn
  type          = "STANDARD"

  depends_on = [
    module.eks_jira_clone,
    module.codebuild_app_charts_deploy
  ]
}

resource "aws_eks_access_policy_association" "codebuild_policy_association_app" {
  cluster_name  = module.eks_jira_clone.cluster_name
  principal_arn = module.codebuild_app_charts_deploy.codebuild_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.codebuild_access_app]
}

resource "aws_eks_access_entry" "codebuild_access_elb" {
  cluster_name  = module.eks_jira_clone.cluster_name
  principal_arn = module.codebuild_elb_charts_deploy.codebuild_role.arn
  type          = "STANDARD"

  depends_on = [
    module.eks_jira_clone,
    module.codebuild_app_charts_deploy
  ]
}

resource "aws_eks_access_policy_association" "codebuild_policy_association_elb" {
  cluster_name  = module.eks_jira_clone.cluster_name
  principal_arn = module.codebuild_elb_charts_deploy.codebuild_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.codebuild_access_elb]
}
