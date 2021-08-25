variable "instance_type" {
  # default     = "t2.micro"
  default     = "t2.medium"
  # default     = "t2.xlarge" # 4	CPUs e 16 GB
  # default     = "t2.2xlarge" # 8	CPUs e 32 GB  
}

variable "quantidade" {
  type        = number
  default     = "4"
}

variable "tamanho_disco" {
  type        = number
  default     = "20"
}

variable "ec2_name" {
  type        = string
  default     = "fiap_vm_medium_2cpus_4gb"
}

variable "key_name" {
  type        = string
  default     = "chave-fiap"
}

variable "aws_region" {
  description = "Regiao do AWS Educate padrao."
  default     = "us-east-1"
}

# Amazon Linux AMI : https://aws.amazon.com/pt/amazon-linux-ami/
variable "aws_amis" {
  default = {
    us-east-1 = "ami-0ff8a91507f77f867"
  }
}
