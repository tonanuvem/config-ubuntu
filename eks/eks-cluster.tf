#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_security_group" "eksfiap" {
  name        = "eksfiap"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.demo.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_eks_cluster" "demo" {
  name     = var.cluster-name
  role_arn = "arn:aws:iam::304686002466:role/eksFiapClusterRole"

  vpc_config {
    security_group_ids = [aws_security_group.eksfiap.id]
    subnet_ids         = aws_subnet.demo[*].id
  }

}
