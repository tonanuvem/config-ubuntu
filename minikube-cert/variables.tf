variable aws_region = "us-east-1"

locals {
  domain_name = "terraform-aws-modules.modules.tf"
}

##################################################################
# Data sources to get VPC and subnets
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

resource "random_pet" "this" {
  length = 2
}

data "aws_route53_zone" "this" {
  name = local.domain_name
}

# Name for role, policy and cloud formation stack (without DBG-DEV- prefix)
variable cluster_name = "my-minikube"

# Instance type
variable aws_instance_type = "t2.medium"

# SSH key for the machine
variable ssh_public_key = "~/.ssh/id_rsa.pub"

# Subnet ID where the minikube should run
variable aws_subnet_id = "subnet-a4ac4efb"

# DNS zone where the domain is placed
variable hosted_zone = "acme.local"
variable hosted_zone_private = true

# AMI image to use (if empty or not defined, latest CentOS 7 will be used)
variable ami_image_id = "ami-07ebfd5b3428b6f4d"

# Tags
variable tags = {
  Application = "Minikube"
}

# Kubernetes Addons
# Supported addons:
#
# https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml
# https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/heapster.yaml
# https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml
# https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml
# https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/ingress.yaml (External ELB load balancer)
# https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/ingress-internal.yaml (Internal ELB loadbalancer)

variable addons = [
  "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/storage-class.yaml",
  "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/metrics-server.yaml",
  "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/dashboard.yaml",
  "https://raw.githubusercontent.com/scholzj/terraform-aws-minikube/master/addons/external-dns.yaml"
]
