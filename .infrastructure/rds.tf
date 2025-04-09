resource "aws_db_subnet_group" "jira-clone-private" {
  name        = "jira-clone-private-subnet-group"
  description = "Jira clone private subnet group"
  subnet_ids  = [aws_subnet.jira-clone-private[0].id, aws_subnet.jira-clone-private[1].id]

  depends_on = [aws_vpc.jira-clone]
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

  vpc_security_group_ids = [aws_security_group.jira-clone-db.id]
  db_subnet_group_name   = aws_db_subnet_group.jira-clone-private.name

  multi_az   = false
  depends_on = [aws_db_subnet_group.jira-clone-private]
}
