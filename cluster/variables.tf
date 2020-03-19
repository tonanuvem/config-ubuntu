variable "hostname" {
  type = "map"
  default = {
    master   = "master"
    node1    = "node1"
    node2    = "node2"
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
