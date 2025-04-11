resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-AmazonEKSWorkerNodePolicy" {
  role      = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"  
}

resource "aws_iam_role_policy_attachment" "eks-cni-AmazonEKS_CNI_Policy" {
  role      = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr-readonly" {
  role      = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "jira-clone" {
  cluster_name = aws_eks_cluster.eks.name
  version = 1.32

  node_group_name = local.app_name
  node_role_arn = aws_iam_role.nodes.arn

  subnet_ids = module.vpc.private_subnets
  capacity_type = "SPOT"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general-purpose"
    app  = local.tags.app
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-cni-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.ecr-readonly
  ]

  lifecycle {
    ignore_changes = [ scaling_config[0].desired_size ]
  }
}