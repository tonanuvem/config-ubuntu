#!/bin/bash

# Diretorio escolhido para salvar os pacotes baixados
cd /usr/local/src/

# --- DEV TOOLS
# Instalacão do Java:
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > /dev/null
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tJava:\n\n"
sudo apt-get -y install default-jre > /dev/null
sudo apt-get -y install default-jdk > /dev/null
sudo apt-get -y install maven > /dev/null
sudo update-alternatives --config java
sudo update-alternatives --config javac
# adiciona as variaveis do java em /etc/environment
sudo cat >> /etc/environment <<EOL
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export JRE_HOME="/usr/lib/jvm/java-11-openjdk-amd64/jre"
export SONAR_SCANNER_OPTS="-Xmx512m"
EOL
#source /etc/environment

# Instalação do Python:
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tPython:\n\n"
sudo add-apt-repository universe
sudo apt-get install -y python3-pip > /dev/null
python3 -m pip install --upgrade --force-reinstall pip
sudo apt-get install -y python3-venv > /dev/null
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
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get install unzip
unzip -q awscliv2.zip
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
curl -s "https://releases.hashicorp.com/terraform/0.12.23/terraform_0.12.23_linux_amd64.zip" -o "terraform_0.12.23_linux_amd64.zip"
unzip terraform_0.12.23_linux_amd64.zip
mv terraform /usr/bin/
#cd ~/terraform/
#DIR_TERRAFORM=$(pwd)
#sudo echo "export PATH=$PATH:$DIR_TERRAFORM" >> /etc/profile
#source /etc/profile
#source ~/.profile

# Instalação das ferramentas K8S:
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tK8S:\n\n"
# minikube
curl -s -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube 
sudo mv minikube /usr/local/bin/
# Variavel abaixo evita que precise executar "sudo chown -R $USER $HOME/.kube $HOME/.minikube" pelo usuario ubuntu
sudo cat >> /etc/environment <<EOL
export CHANGE_MINIKUBE_NONE_USER=true
EOL
# kubectl
curl -s -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
# kubectl bash completion : todo
# apt-get install bash-completion
# sudo echo "source <(kubectl completion bash)" >> /etc/profile
mkdir /home/ubuntu/.minikube/
# sudo chmod +r /home/ubuntu/.kube/config
# sudo chmod +r /home/ubuntu/.minikube/client.key
# helm
wget --no-verbose https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz
tar -zxvf helm-v2.14.3-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm


# Verificando as versões instaladas e atualizar permissão docker:
cd ~
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tVerificando as instações:\n\n"
printf "\n\n\tDEV TOOLS:\n\n"
printf "\n\tJAVA:\n"
java -version
javac -version
printf "\n\tMAVEN:\n"
mvn -version
printf "\n\tPYTHON:\n"
python3 --version
printf "\n\tPIP:\n"
pip3 --version
printf "\n\n\tOPS TOOLS:\n\n"
printf "\n\tDOCKER:\n"
sudo docker version
docker-compose --version
printf "\n\tAWSCLI:\n"
aws --version
printf "\n\tTERRAFORM:\n"
terraform --version
printf "\n\tMINIKUBE:\n"
minikube version
printf "\n\tKUBECTL:\n"
kubectl version --client
printf "\n\tHELM:\n"
helm version -c
