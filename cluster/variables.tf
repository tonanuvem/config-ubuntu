variable "hostname" {
  type = map
  default = {
    # master   = "master"
    node1    = "node1"
    node2    = "node2"
    node3    = "node3"   
  }
}

variable "ec2_name" {
  type = map
  default = {
    node1     = "clusterfiap_node1_medium_2cpus_4gb"
    node2     = "clusterfiap_node2_medium_2cpus_4gb"
    node3     = "clusterfiap_node3_medium_2cpus_4gb"
  }
}

variable "instance_type" {
  # default     = "t2.micro"
  default     = "t2.medium"
}

variable "key_name" {
  type        = string
  default     = "chave-fiap"
}

variable "aws_region" {
  description = "Regiao do AWS Educate padrao."
  default     = "us-east-1"
}

# Ubuntu 18.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-1 = "ami-07ebfd5b3428b6f4d"
  }
}
