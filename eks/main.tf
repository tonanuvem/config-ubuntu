# Providers:

terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

data "aws_availability_zones" "available" {}

resource "aws_vpc" "demo" {
  cidr_block = "10.5.0.0/16"
  enable_dns_hostnames = true
  tags = map(
    "name", "eksfiap",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "demo" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.5.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.demo.id

  tags = map(
    "name", "eksfiap",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    name = "eksfiap"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id
  tags = {
    name = "eksfiap"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
}

resource "aws_route_table_association" "demo" {
  count = 2

  subnet_id      = aws_subnet.demo.*.id[count.index]
  route_table_id = aws_route_table.demo.id
}

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
    name = "eksfiap"
  }
}

resource "aws_eks_cluster" "eksfiap" {
  name     = var.cluster-name
  role_arn = "arn:aws:iam::497573848553:role/eksFiapClusterRole"

  vpc_config {
    security_group_ids = [aws_security_group.eksfiap.id]
    subnet_ids         = aws_subnet.demo[*].id
  }

}

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
  remote_access {
    ec2_ssh_key = "chave-fiap"
  }
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
}
