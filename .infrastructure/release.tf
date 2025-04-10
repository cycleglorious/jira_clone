resource "helm_release" "jira_clone_app" {
  name      = "jira-clone-app"
  chart     = "../.helm/jira-clone"
  namespace = "default"

  values = [
    yamlencode({
      runMigrations = var.run_migrations
      runSeed = var.run_seed
      postgresql = {
        auth = {
          database = aws_db_instance.jira-clone.db_name 
          username = data.vault_generic_secret.database.data["db_username"]
          password = data.vault_generic_secret.database.data["db_password"]
        }
        dbHost = aws_db_instance.jira-clone.endpoint
        # dbPort = module.jira_clone_rds.db_instance_port
      },
      configs = {
        clerkPublishableKey : data.vault_generic_secret.clerk.data["CLERK_SECRET_KEY"]
      }
      upstash = {
        token = data.vault_generic_secret.upstash.data["token"]
      }
    })
  ]
}
