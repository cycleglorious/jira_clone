resource "aws_db_subnet_group" "jira-clone-private" {
  name        = "jira-clone-private-subnet-group"
  description = "Jira clone private subnet group"
  subnet_ids  = module.vpc.private_subnets

  depends_on = [module.vpc]
}

resource "aws_db_instance" "jira-clone" {
  allocated_storage   = 10
  engine              = "postgres"
  instance_class      = var.db_instance_type
  username            = data.vault_generic_secret.database.data["db_username"]
  password            = data.vault_generic_secret.database.data["db_password"]
  db_name             = var.db_name
  identifier          = "jira-clone-db"
  skip_final_snapshot = true
  publicly_accessible = false

  vpc_security_group_ids = [module.jira_clone_db_sg.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.jira-clone-private.name

  multi_az   = false
  depends_on = [module.vpc]
}

# module "jira_clone_rds" {
#   source  = "terraform-aws-modules/rds/aws"
#   version = "6.11.0"

#   identifier = "${local.app_name}-db"

#   engine            = "postgres"
#   engine_version    = var.db_engine_version
#   instance_class    = var.db_instance_type
#   family            = var.db_family
#   allocated_storage = 10
#   storage_encrypted = true
  

#   db_name  = var.db_name
#   port     = var.db_port
#   username = data.vault_generic_secret.database.data["db_username"]
#   password = data.vault_generic_secret.database.data["db_password"]

#   subnet_ids             = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
#   vpc_security_group_ids = [module.jira_clone_db_sg.security_group_id]


#   multi_az            = false
#   publicly_accessible = false
#   skip_final_snapshot = true

#   tags = {
#     Name = "${local.app_name}-db"
#     app  = local.tags.app
#   }
# }
