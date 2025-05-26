resource "aws_eks_cluster" "eks" {
  name     = "iti-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
       var.subent1,
       var.subnet2
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy
  ]
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [
    var.subent1,
    var.subnet2
  ]
  scaling_config {
    desired_size = 2
    max_size     = var.max_node
    min_size     = var.min_node
  }

  depends_on = [
    aws_eks_cluster.eks
  ]
}
