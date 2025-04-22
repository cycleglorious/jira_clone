data "aws_iam_policy_document" "jira-clone-lb" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "jira-clone-lb" {
  name               = "jira-clone-lb-role"
  assume_role_policy = data.aws_iam_policy_document.jira-clone-lb.json
}

resource "aws_iam_policy" "jira-clone-lb" {
  name   = "AWSLoadBalancerController"
  policy = file("./iam/iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "jira-clone-lb" {
  policy_arn = aws_iam_policy.jira-clone-lb.arn
  role       = aws_iam_role.jira-clone-lb.name
}



resource "aws_eks_pod_identity_association" "jira-clone-lb" {
  cluster_name    = module.eks_jira_clone.cluster_name
  role_arn        = aws_iam_role.jira-clone-lb.arn
  service_account = "aws-load-balancer-controller"
  namespace       = "kube-system"

  depends_on = [
    aws_iam_role_policy_attachment.jira-clone-lb
  ]
}
