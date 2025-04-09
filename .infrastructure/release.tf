resource "helm_release" "jira_clone_app" {
  name       = "jira-clone-app"
  chart      = "../.helm/jira-clone"
  namespace  = "default"

  values = [
    yamlencode({
      postgresql = {
        auth = {
          database = aws_db_instance.jira-clone.db_name
          username = aws_db_instance.jira-clone.username
          password = aws_db_instance.jira-clone.password
        }
        dbHost = aws_db_instance.jira-clone.endpoint
        dbPort = aws_db_instance.jira-clone.port
      },
      configs = {        
        clerkPublishableKey: data.vault_generic_secret.clerk.data["CLERK_SECRET_KEY"]
      }
      upstash = {
        token = data.vault_generic_secret.upstash.data["token"]
      }
    })
  ]
}