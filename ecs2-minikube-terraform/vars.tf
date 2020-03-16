variable "instance_ami_id" {
  type    = "string"
  default = "ami-0cc293023f983ed53"
}
variable "instance_type" {
  type    = "string"
  default = "t3.large"
}

variable "instance_tags" {
  type    = "map"
  default = {}
}

variable "instance_vpc_id" {
  type    = "string"
  default = "vpc-02f45832e96006e98"
}

variable "instance_subnet_id" {
  type    = "string"
  default = "subnet-064f867a2028b70b9"
}

variable "instance_key_name" {
  type    = "string"
  default = "Trial-pair"
}

variable "aws_profile_name" {
  type    = "string"
  default = "onelogin"
}

variable "aws_region" {
  type    = "string"
  default = "eu-central-1"
}

variable "ec2_ingress_cidr" {
  type    = list(string)
  default = ["92.75.28.171/32"]
}
