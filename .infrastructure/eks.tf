resource "aws_iam_role" "eks" {
  name = "eks-iam-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [ aws_iam_role_policy_attachment.eks ]
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "eks-pod-identity-agent"

  depends_on = [ aws_eks_cluster.eks ]

  tags = {
     Name = "${aws_eks_cluster.eks.name}-pod-identity-agent"
  }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE" 
  resolve_conflicts_on_update = "OVERWRITE" 

  depends_on = [ aws_eks_cluster.eks ] 

  tags = { Name = "${aws_eks_cluster.eks.name}-vpc-cni" }
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [ aws_eks_cluster.eks ]

  tags = { Name = "${aws_eks_cluster.eks.name}-kube-proxy" }
}
