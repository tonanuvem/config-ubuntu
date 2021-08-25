# Define o provedor AWS onde serão criados os recursos
provider "aws" {
  region = var.aws_region
}

# Cria um VPC que receberá as instâncias e recursos
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
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
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Cria um "security group" para o EC2 visando permitir o acesso Web
resource "aws_security_group" "default" {
  name        = "fiap-ec2-security-group-ec2-instance"
  description = "Grupo de seguranca do EC2"
  vpc_id      = aws_vpc.default.id

  # Acesso TOTAL de qualquer um
  ingress {
    from_port   = 0
    to_port     = 65353
    protocol    = "tcp"
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
  template = file("${path.module}/config.sh")
}

resource "aws_instance" "web" {
  count = var.quantidade # create similar EC2 instances
  
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ec2-user"
    host = self.public_ip
    # The connection will use the local SSH agent for authentication.
  }
  
  # Define o script de inicialização do EC2:
  user_data = data.template_file.init.rendered
  
  # Define a chave
  key_name  = var.key_name
  
  # Define o nome da VM : "${format("%s_%d_%s", "aluno", count.index, var.ec2_name)}"
  tags = {
    Name = "${format("%s_%d_%s", "vm", count.index, var.ec2_name)}"
    # Name = "${format("%s_%d_%s", "vm", count.index+1, var.ec2_name)}"
  }  
  
  # Define tipo da VM (CPU e Memoria)
  instance_type = var.instance_type

  # Criar um disco com 30 GB
  root_block_device {
    volume_size = var.tamanho_disco
  }
  
  # Volume Elastic Block Service: EBS volumes (remote storage devices)
  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_size = var.tamanho_disco
  }
  
  # Versão do Sistema Operacional (Ubuntu)
  ami = lookup(var.aws_amis, var.aws_region)

  # Chave: SSH keypair
  # key_name = aws_key_pair.auth.id

  # Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = aws_subnet.default.id
}
