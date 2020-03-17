variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "chave-fiap.pem"
}

variable "aws_region" {
  description = "Região do AWS Educate padrão."
  default     = "us-east-1"
}

# Ubuntu 18.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-1 = "ami-07ebfd5b3428b6f4d"
  }
}
