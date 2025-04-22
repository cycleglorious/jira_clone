{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:logs:eu-north-1:792642165337:log-group:/aws/codebuild/${project_name}:*",
        "arn:aws:logs:eu-north-1:792642165337:log-group:/aws/codebuild/${project_name}:*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::codepipeline-eu-north-1-*"
      ],
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation"
      ]
    },
    {
      "Action": [
        "ecr:GetRegistryPolicy",
        "ecr:DescribeImageScanFindings",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:GetDownloadUrlForLayer",
        "ecr:DescribeRegistry",
        "ecr:DescribePullThroughCacheRules",
        "ecr:DescribeImageReplicationStatus",
        "ecr:DescribeRepositoryCreationTemplates",
        "ecr:GetAuthorizationToken",
        "ecr:ListTagsForResource",
        "ecr:ListImages",
        "ecr:BatchGetRepositoryScanningConfiguration",
        "ecr:GetRegistryScanningConfiguration",
        "ecr:ValidatePullThroughCacheRule",
        "ecr:GetAccountSetting",
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetImageCopyStatus",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy",
        "ecr:GetLifecyclePolicy"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:BatchPutCodeCoverages"
      ],
      "Resource": [
        "arn:aws:codebuild:eu-north-1:792642165337:report-group/${project_name}-*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "arn:aws:codestar-connections:eu-north-1:792642165337:connection/*"
    }
    
  ]
}