#!/bin/bash

# --- DEV TOOLS
# Instalacão do Java:
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -y
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tJava:\n\n"
sudo apt-get install -y default-jre
sudo apt-get install -y default-jdk
sudo apt-get install -y maven
sudo update-alternatives --config java
sudo update-alternatives --config javac
# adiciona as variaveis do java em /etc/environment
sudo cat >> /etc/environment <<EOL
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export JRE_HOME="/usr/lib/jvm/java-11-openjdk-amd64/jre"
EOL
source /etc/environment

# Instalação do Python:
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tPython:\n\n"
sudo add-apt-repository universe
sudo apt-get install -y python3-pip
sudo apt-get install -y python3-venv
pip3 install --upgrade pip

# --- OPS TOOLS
# Instalação do Docker
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tDocker:\n\n"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
# sudo gpasswd -a $USER docker
sudo gpasswd -a ubuntu docker

# Instalar o docker-compose
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tDocker-compose:\n\n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Instalação da AWS CLI
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tAWS CLI e SSH:\n\n"
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
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tTerraform:\n\n"
cd /usr/local/src/
curl "https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip" -o "terraform_0.12.23_linux_amd64.zip"
unzip terraform_0.12.23_linux_amd64.zip
mv terraform /usr/bin/
#cd ~/terraform/
#DIR_TERRAFORM=$(pwd)
#sudo echo "export PATH=$PATH:$DIR_TERRAFORM" >> /etc/profile
#source /etc/profile
#source ~/.profile

# Verificando as versões instaladas e atualizar permissão docker:
cd ~
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tVerificando as instações:\n\n"
printf "\n\n\tDEV TOOLS:\n\n"
java -version
javac -version
mvn -version
python3 --version
pip3 --version
printf "\n\n\tOPS TOOLS:\n\n"
sudo docker version
docker-compose --version
aws --version
terraform --version
newgrp docker
