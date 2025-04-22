resource "aws_iam_policy" "codebuild_eks" {
  name = "${var.project_name}-eks-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "eks:AccessKubernetesApi",
          "eks:DescribeCluster",
          "eks:DescribeAccessEntry"
        ],
        Resource = var.eks_cluster_arn
      }
    ]
  })
}

resource "aws_iam_role" "codebuild" {
  name = "${var.project_name}-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "codebuild_vpc" {
  name   = "CodeBuildVPCPolicy-${var.project_name}"
  policy = templatefile("${path.module}/iam/CodeBuildVpcPolicy.json.tpl", { subnet_ids = var.private_subnets })
}

resource "aws_iam_policy" "codebuild_base" {
  name   = "CodeBuildBasePolicy-${var.project_name}"
  policy = templatefile("${path.module}/iam/CodeBuildBasePolicy.json.tpl", { project_name = var.project_name })
}

resource "aws_iam_policy" "codebuild_secrets_policy" {
  count       = var.create_secrets_policy ? 1 : 0
  name        = "${var.project_name}-secrets-policy"
  description = "Policy to allow CodeBuild to read specific secrets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "ReadDBCredentialsSecret",
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = var.secrets_manager_db_secret_arn
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_attach" {
  count      = var.create_secrets_policy ? 1 : 0
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_secrets_policy[0].arn
}


resource "aws_iam_role_policy_attachment" "vpc" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_vpc.arn
}

resource "aws_iam_role_policy_attachment" "eks" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_eks.arn
}

resource "aws_iam_role_policy_attachment" "base" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_base.arn
}

resource "aws_codebuild_project" "this" {
  name         = var.project_name
  service_role = aws_iam_role.codebuild.arn

  source {
    type      = "NO_SOURCE"
    buildspec = var.buildspec
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.private_subnets
    security_group_ids = [var.eks_security_group_id]
  }
}
