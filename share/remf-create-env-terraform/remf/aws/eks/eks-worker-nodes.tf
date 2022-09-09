#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "project-eks-cluster-nodes" {{
  name = "{project}-eks-cluster-nodes"

  assume_role_policy = <<POLICY
{{
  "Version": "2012-10-17",
  "Statement": [
    {{
      "Effect": "Allow",
      "Principal": {{
        "Service": "ec2.amazonaws.com"
      }},
      "Action": "sts:AssumeRole"
    }}
  ]
}}
POLICY
}}

resource "aws_iam_role_policy_attachment" "project-eks-cluster-nodes-AmazonEKSWorkerNodePolicy" {{
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.project-eks-cluster-nodes.name
}}

resource "aws_iam_role_policy_attachment" "project-eks-cluster-nodes-AmazonEKS_CNI_Policy" {{
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.project-eks-cluster-nodes.name
}}

resource "aws_iam_role_policy_attachment" "project-eks-cluster-nodes-AmazonEC2ContainerRegistryReadOnly" {{
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.project-eks-cluster-nodes.name
}}

resource "aws_eks_node_group" "project-eks-nodes" {{
  cluster_name    = aws_eks_cluster.project-eks-cluster.name
  node_group_name = "{project}-eks-nodes"
  node_role_arn   = aws_iam_role.project-eks-cluster-nodes.arn
  subnet_ids      = aws_subnet.project-eks-subnet[*].id
  instance_types  = var.eks_worker_nodes_instance_type

  scaling_config {{
    desired_size = var.eks_node_scaling_desired_size
    max_size     = var.eks_node_scaling_max_size
    min_size     = var.eks_node_scaling_min_size
  }}

  depends_on = [
    aws_iam_role_policy_attachment.project-eks-cluster-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.project-eks-cluster-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.project-eks-cluster-nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}}