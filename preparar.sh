#!/bin/bash

# Instalação do Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo gpasswd -a $USER docker

# Instalar o docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Instalação da AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get install unzip
unzip awscliv2.zip
sudo ./aws/install

# Criar arquivo vazio das credenciais da AWS:
mkdir ~/.aws
touch ~/.aws/credentials

# Habilitar a configuração para o servidor não derrubar suas conexões:
echo 'ClientAliveInterval 60' | sudo tee --append /etc/ssh/sshd_config
sudo service ssh restart

# Instalação do Terraform:
wget https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip
unzip terraform_0.12.23_linux_amd64.zip
DIR_TERRAFORM=$(pwd)
echo "export PATH=$PATH:$DIR_TERRAFORM" >> /etc/profile

# Verificando as versões instaladas e atualizar permissão docker:
printf "--------------------------------------------------\n"
printf "\n\n\tVerificando as instações:\n\n"
sudo docker version
docker-compose --version
aws --version
newgrp docker
