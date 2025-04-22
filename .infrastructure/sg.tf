module "jira_clone_app_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${local.app_name}-app-sg"
  description = "Jira clone app security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "Allow HTTP to port 3000"
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    Name = "${local.app_name}-app-sg"
    app  = local.tags.app
  }
}
module "jira_clone_db_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name                = "${local.app_name}-db-sg"
  description         = "Jira clone db security group"
  vpc_id              = module.vpc.vpc_id
  
  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_with_cidr_blocks = [
    {
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = "tcp"
      description = "Allow Postgres"
    }
  ]

  egress_cidr_blocks = module.vpc.private_subnets_cidr_blocks

  tags = {
    Name = "${local.app_name}-db-sg"
    app  = local.tags.app
  }
}
