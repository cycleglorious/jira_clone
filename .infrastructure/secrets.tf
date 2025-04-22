resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name        = var.secret_name
  description = "Credentials for ${local.app_name}"

  tags = {
    app = local.tags.app
  }

  # lifecycle {
  #   prevent_destroy = true
  # }

}

resource "aws_secretsmanager_secret_version" "db_credentials_initial_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    db_username       = var.db_username
    db_password       = random_password.db_password.result
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

data "aws_secretsmanager_secret_version" "current_db_credentials" {
  secret_id  = aws_secretsmanager_secret.db_credentials.id
  depends_on = [aws_secretsmanager_secret_version.db_credentials_initial_version]
}
