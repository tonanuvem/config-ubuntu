#!/bin/bash

# utils: cria script para verificar ip publico.
sudo cat >> /home/ubuntu/ip <<EOL
curl checkip.amazonaws.com
EOL
chmod +x /home/ubuntu/ip

# --- DEV TOOLS
# Instalacão do Java:
# Instalação do Python:

# --- OPS TOOLS

# Instalar o docker-compose
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tDocker-compose:\n\n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Instalação da AWS CLI
# Criar arquivo vazio das credenciais da AWS:
# Habilitar a configuração para o servidor não derrubar suas conexões:

# Instalação do Terraform:
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tTerraform:\n\n"
curl -s "https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip" -o "terraform_linux_amd64.zip"
unzip terraform_linux_amd64.zip
mv terraform /usr/bin/

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
# kubeadm kubelet kubectl
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-get -y update
apt-get -y install kubeadm kubelet kubectl

# helm
# curl -s https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz -o helm-linux-amd64.tar.gz
curl -s https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz -o helm-linux-amd64.tar.gz
tar -zxvf helm-linux-amd64.tar.gz
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
