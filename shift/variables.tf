variable "instance_type" {
  # default     = "t2.micro"
  default     = "t2.medium"
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

# Ubuntu 18.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-1 = "ami-07ebfd5b3428b6f4d"
  }
}

# Usado para definir a chave com base na chave publica
/*
variable "public_key_path" {
  default     = "public_key.pem"
#  description = <<DESCRIPTION
#Verificar a saida do comando: ssh-keygen -y -f ./chave-fiap.pem
#Exemplo: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41"
#DESCRIPTION
}
*/
