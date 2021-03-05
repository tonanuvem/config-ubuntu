# Define o provedor AWS onde serão criados os recursos
provider "aws" {
  region = var.aws_region
}

# Cria um VPC que receberá as instâncias e recursos
resource "aws_vpc" "default" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
}
# Cria um Internet Gateway que possibilita a comunicação do VPN com o mundo externo
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}
# Cria a Regra que permite acesso a Internet de/para o VPC
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}
# Cria uma subrede no VPC que ira receber as instâncias
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
}

# Cria um "security group" para o EC2 visando permitir o acesso Web
resource "aws_security_group" "default" {
  name        = "fiap-cluster-security-group"
  description = "Grupo de seguranca do Cluster"
  vpc_id      = aws_vpc.default.id

  # LAB TEMPORARIO - JAMAIS EM PRD
  # Acesso TOTAL de qualquer um
  # portas TCP
  ingress {
    from_port   = 0
    to_port     = 65353
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # portas UDP
  ingress {
    from_port   = 0
    to_port     = 65353
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  
  # Acesso de saida para internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Para verificar o resultado do script: cat /var/log/cloud-init-output.log
data "template_file" "init" {
  template = file("${path.module}/../preparar.sh")
}
/*
data "template_file" "master" {
  template = file("${path.module}/config-node1.sh")
}
data "template_file" "node1" {
  template = file("${path.module}/config-node2.sh")
}
data "template_file" "node2" {
  template = file("${path.module}/config-node3.sh")
}
# Render a part using a `template_file`
# Render a multi-part cloud-init config 
data "template_cloudinit_config" "config_master" {
  gzip          = true
  base64_encode = true
  # scripts em varias partes:
  part {
    filename     = "config-master.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.master.rendered
  }
  part {
    filename     = "../preparar.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.init.rendered
  }
}
data "template_cloudinit_config" "config_node1" {
  #gzip          = true
  #base64_encode = true
  # scripts em varias partes:
  #part {
  #  filename     = "config-node1.sh"
  #  content_type = "text/x-shellscript"
  #  content      = file("${path.module}/config-node1.sh")
  #}
  part {
    content_type = "text/cloud-config"
    content      = "hostname: node1"
  }
  part {
    content_type = "text/x-shellscript"
    #content      = file("${path.module}/../preparar.sh")
    content      = data.template_file.init.rendered
  }
}
data "template_cloudinit_config" "config_node2" {
  gzip          = true
  base64_encode = true
  # scripts em varias partes:
  part {
    filename     = "config-node2.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/config-node2.sh")
  }
  part {
    filename     = "preparar.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.init.rendered
  }
}
*/

resource "aws_instance" "node1" {  
  # Define o script de inicialização do EC2:
  # user_data = data.template_file.init.rendered
  #user_data = data.template_cloudinit_config.config_master.rendered
  user_data = data.template_file.init.rendered
  
  # Define a chave
  key_name  = var.key_name
  # Define o nome da VM
  tags = {
    Name = lookup(var.ec2_name, "node1")
  } 
  
  # Define tipo da VM (CPU e Memoria)
  instance_type = var.instance_type
  
  # Criar um disco com 30 GB
  root_block_device {
    volume_size = 30
  }
  
  # Versão do Sistema Operacional (Ubuntu)
  ami = lookup(var.aws_amis, var.aws_region)
  
  # Security group e subnets
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = aws_subnet.default.id
}

resource "aws_instance" "node2" {  
  # Define o script de inicialização do EC2:
  #user_data = data.template_cloudinit_config.config_node1.rendered
  user_data = data.template_file.init.rendered
  
  # Define a chave
  key_name  = var.key_name
  # Define o nome da VM
  tags = {
    Name = lookup(var.ec2_name, "node2")
  } 
  
  # Define tipo da VM (CPU e Memoria)
  instance_type = var.instance_type
  
  # Criar um disco com 30 GB
  root_block_device {
    volume_size = 30
  }
  
  # Versão do Sistema Operacional (Ubuntu)
  ami = lookup(var.aws_amis, var.aws_region)
  
  # Security group e subnets
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = aws_subnet.default.id
}

resource "aws_instance" "node3" {  
  # Define o script de inicialização do EC2:
  user_data = data.template_file.init.rendered
  
  # Define a chave
  key_name  = var.key_name
  # Define o nome da VM
  tags = {
    Name = lookup(var.ec2_name, "node3")
  } 
  
  # Define tipo da VM (CPU e Memoria)
  instance_type = var.instance_type
  
  # Criar um disco com 30 GB
  root_block_device {
    volume_size = 30
  }
  
  # Versão do Sistema Operacional (Ubuntu)
  ami = lookup(var.aws_amis, var.aws_region)
  
  # Security group e subnets
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id = aws_subnet.default.id
}
