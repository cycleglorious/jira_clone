version: 0.2

phases:
  install:
    commands:
      - curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

  pre_build:
    commands:
      - helm repo add eks https://aws.github.io/eks-charts
      - helm repo update eks
      - aws eks --region ${region} update-kubeconfig --name ${eks_cluster_name}
      - aws ecr get-login-password --region ${region} | helm registry login --username AWS --password-stdin 792642165337.dkr.ecr.eu-north-1.amazonaws.com

  build:
    commands:
      - | 
          helm upgrade --install aws-load-balancer-controller \
          eks/aws-load-balancer-controller \
          --version "1.7.2" \
          --namespace "kube-system" \
          --create-namespace \
          --set clusterName=jira-clone-eks \
          --set serviceAccount.name="aws-load-balancer-controller" \
          --set vpcId=${vpc_id} \
          --set region=${region}


