#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_eks_node_group" "demo" {
  cluster_name    = aws_eks_cluster.eksfiap.name
  node_group_name = "demo"
  node_role_arn   = "arn:aws:iam::497573848553:role/eksFiapWorker"
  subnet_ids      = aws_subnet.demo[*].id
  tags = {
    name = "eksfiap-workers"
  }
  ec2_ssh_key = "chave-fiap"
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
