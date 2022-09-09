#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "project-eks-cluster" {{
  name = "{project}-eks-cluster"

  assume_role_policy = <<POLICY
{{
  "Version": "2012-10-17",
  "Statement": [
    {{
      "Effect": "Allow",
      "Principal": {{
        "Service": "eks.amazonaws.com"
      }},
      "Action": "sts:AssumeRole"
    }}
  ]
}}
POLICY
}}

resource "aws_iam_role_policy_attachment" "project-eks-AmazonEKSClusterPolicy" {{
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.project-eks-cluster.name
}}

resource "aws_iam_role_policy_attachment" "project-eks-vpc-AmazonEKSVPCResourceController" {{
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.project-eks-cluster.name
}}

resource "aws_security_group" "project-eks" {{
  name        = "{project}-eks-sg-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.project-eks-vpc.id 
  
  egress {{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }}
  ingress {{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }}
  ingress {{
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }}

  tags = {{
    Name = "{project}-eks-cluster"
    Env = "{env_lower}"
  }}
}}

#resource "aws_security_group_rule" "eks-ingress" {{
#  from_port                = 443
#  protocol                 = "tcp"
#  security_group_id        = "aws_security_group.project-eks.id"
#  to_port                  = 443
#  type                     = "ingress"
#}}

resource "aws_eks_cluster" "project-eks-cluster" {{
  name     = "{project}-eks-cluster"
  role_arn = aws_iam_role.project-eks-cluster.arn

  vpc_config {{
    security_group_ids = [aws_security_group.project-eks.id]
    subnet_ids         = aws_subnet.project-eks-subnet[*].id
  }}

  encryption_config {{
    resources = var.eks_encryption_config_resources
    provider {{
      key_arn = aws_kms_key.eks.arn
    }}
  }}
  
  depends_on = [
    aws_iam_role_policy_attachment.project-eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.project-eks-vpc-AmazonEKSVPCResourceController,
  ]
}}