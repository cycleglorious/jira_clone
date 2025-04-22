version: 0.2

phases:
  install:
    commands:
      - curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  pre_build:
    commands:
      - aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name $EKS_CLUSTER_NAME
      - aws ecr get-login-password --region eu-north-1 | helm registry login --username AWS --password-stdin 792642165337.dkr.ecr.eu-north-1.amazonaws.com
      - SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "${secrets_manager_db_secret_arn}" --query SecretString --output text --region $AWS_DEFAULT_REGION)
      - |
        DB_USERNAME=$(echo $SECRET_JSON | jq -r .db_username)
        DB_PASSWORD=$(echo $SECRET_JSON | jq -r .db_password)
        CLERK_SECRET_KEY=$(echo $SECRET_JSON | jq -r .clerk_secret_key)
        UPSTASH_REDIS_REST_TOKEN=$(echo $SECRET_JSON | jq -r .upstash_api_token)


  build:
    commands:
      - | 
          helm upgrade --install jira-clone \
          oci://792642165337.dkr.ecr.eu-north-1.amazonaws.com/jira-clone \
          --set postgresql.auth.username=$DB_USERNAME \
          --set postgresql.auth.password=$DB_PASSWORD \
          --set postgresql.auth.database=${db_name} \
          --set postgresql.dbHost=${db_host} \
          --set upstash.token=$UPSTASH_REDIS_REST_TOKEN \
          --set configs.nextPublicClerkPublishableKey=${next_public_clerk_publishable_key} \
          --set configs.clerkPublishableKey=$CLERK_SECRET_KEY \
          --set runMigrations=${run_migrations} \
          --set runSeed=${run_seed}

env:
  variables:
    AWS_DEFAULT_REGION: "eu-north-1"
    EKS_CLUSTER_NAME: "jira-clone-eks"
