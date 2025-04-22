module "codebuild_app_charts_deploy" {
  source = "./modules/codebuild_helm_deploy"

  project_name    = "JiraCloneDeployHelmCharts"
  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_cluster_arn               = module.eks_jira_clone.cluster_arn
  eks_cluster_name              = module.eks_jira_clone.cluster_name
  eks_security_group_id         = module.eks_jira_clone.cluster_security_group_id
  secrets_manager_db_secret_arn = aws_secretsmanager_secret.db_credentials.arn
  create_secrets_policy         = true

  buildspec = templatefile("./codebuild/helm-app-deploy.yaml.tpl", {
    secrets_manager_db_secret_arn     = data.aws_secretsmanager_secret_version.current_db_credentials.arn
    db_name                           = aws_db_instance.jira-clone.db_name
    db_host                           = aws_db_instance.jira-clone.endpoint
    upstash_token                     = var.upstash_api_token
    next_public_clerk_publishable_key = var.next_public_clerk_publishable_key
    clerk_secret_key                  = var.clerk_secret_key
    run_migrations                    = var.run_migrations
    run_seed                          = var.run_seed
  })

  depends_on = [module.vpc]
}

module "codebuild_elb_charts_deploy" {
  source = "./modules/codebuild_helm_deploy"

  project_name    = "JiraCloneDeployELBCharts"
  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_cluster_arn       = module.eks_jira_clone.cluster_arn
  eks_cluster_name      = module.eks_jira_clone.cluster_name
  eks_security_group_id = module.eks_jira_clone.cluster_security_group_id

  buildspec = templatefile("./codebuild/helm-elb-deploy.yaml.tpl", {
    region           = var.region
    eks_cluster_name = var.cluster_name
    vpc_id           = module.vpc.vpc_id
  })

  depends_on = [module.vpc]
}


resource "null_resource" "trigger_codebuild_elb" {
  depends_on = [module.codebuild_elb_charts_deploy, aws_eks_access_entry.codebuild_access_elb]

  triggers = {
    project_arn  = module.codebuild_elb_charts_deploy.codebuild_project_arn
    project_name = module.codebuild_elb_charts_deploy.codebuild_project_name
  }

  provisioner "local-exec" {
    command = "aws codebuild start-build --project-name ${self.triggers.project_name}"
  }
}

resource "time_sleep" "wait_for_codebuild_elb" {
  depends_on = [ null_resource.trigger_codebuild_elb ]

  create_duration = "80s"
}

resource "null_resource" "trigger_codebuild_app" {
  depends_on = [module.codebuild_elb_charts_deploy, null_resource.trigger_codebuild_elb, module.codebuild_app_charts_deploy, time_sleep.wait_for_codebuild_elb]

  triggers = {
    project_arn  = module.codebuild_app_charts_deploy.codebuild_project_arn
    project_name = module.codebuild_app_charts_deploy.codebuild_project_name
  }

  provisioner "local-exec" {
    command = "aws codebuild start-build --project-name ${self.triggers.project_name}"
  }
}
