resource "aws_db_subnet_group" "jira-clone-private" {
  name        = "${local.app_name}-private-subnet-group"
  description = "Jira clone private subnet group"
  subnet_ids  = module.vpc.private_subnets

  depends_on = [module.vpc]
}

resource "aws_db_instance" "jira-clone" {
  allocated_storage   = 10
  engine              = "postgres"
  instance_class      = var.db_instance_type
  username            = jsondecode(data.aws_secretsmanager_secret_version.current_db_credentials.secret_string).db_username
  password            = jsondecode(data.aws_secretsmanager_secret_version.current_db_credentials.secret_string).db_password
  db_name             = var.db_name
  identifier          = "jira-clone-db"
  skip_final_snapshot = true
  publicly_accessible = false

  vpc_security_group_ids = [module.jira_clone_db_sg.security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.jira-clone-private.name

  multi_az   = false
  depends_on = [module.vpc, aws_secretsmanager_secret_version.db_credentials_initial_version]
}
