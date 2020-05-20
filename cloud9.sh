#!/bin/bash

# https://code.visualstudio.com/docs/remote/ssh

# utils: cria script para verificar ip publico.
sudo cat >> ~/environment/ip <<EOL
curl checkip.amazonaws.com
EOL
chmod +x ~/environment/ip

# aumentando o disco para 20G e 
sh ~/environment/config-ubuntu/resize.sh > /dev/null
#sh ~/environment/config-ubuntu/firewall_allow.sh
sh ~/environment/config-ubuntu/resize.sh > /dev/null

# --- DEV TOOLS
# Instalacão do Maven Java:
export DEBIAN_FRONTEND=noninteractive
#sudo apt-get update > /dev/null
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tMaven (Java):\n\n"
#sudo apt-get -y install maven > /dev/null # nao funciona no comeco por conta internos dos scripts do cloud9
# Instalação do SPRING:
curl -s "https://get.sdkman.io" | bash > /dev/null
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install springboot
spring version

# --- OPS TOOLS

# Instalar o docker-compose
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tDocker-compose:\n\n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Instalação da Elastic Beanstalk CLI
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev > /dev/null
git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
# ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
python3 aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py
echo 'export PATH="/home/ubuntu/.ebcli-virtual-env/executables:$PATH"' >> ~/.bash_profile && source ~/.bash_profile
echo 'export PATH=/home/ubuntu/.pyenv/versions/3.7.2/bin:$PATH' >> /home/ubuntu/.bash_profile && source /home/ubuntu/.bash_profile
rm -rf aws-elastic-beanstalk-cli-setup

# Instalação do Terraform:
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tTerraform:\n\n"
curl -s "https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip" -o "terraform_linux_amd64.zip"
unzip terraform_linux_amd64.zip
sudo mv terraform /usr/bin/
rm -rf terraform_linux_amd64.zip

# Instalação das ferramentas K8S:
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tK8S:\n\n"
# minikube
curl -s -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube 
sudo mv minikube /usr/bin/
# Variavel abaixo evita que precise executar " pelo usuario ubuntu
# sudo chown -R $USER $HOME/.kube $HOME/.minikube
#sudo cat >> /etc/environment <<EOL
#export CHANGE_MINIKUBE_NONE_USER=true
#EOL
# kubeadm kubelet kubectl
#echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
# sudo snap update
sudo snap install kubectl --classic

# helm
# curl -s https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz -o helm-linux-amd64.tar.gz
curl -s https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz -o helm-linux-amd64.tar.gz
tar -zxvf helm-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64
rm -rf helm-linux-amd64.tar.gz

# Verificando as versões instaladas e atualizar permissão docker:
cd ~
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tVerificando as instações:\n\n"
printf "\n\n\tDEV TOOLS:\n\n"
printf "\n\tJAVA:\n"
java -version
javac -version
#printf "\n\tMAVEN:\n"
#mvn -version
printf "\n\tSPRING:\n"
spring --version
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
printf "\n\tElastic Beanstalker CLI:\n"
eb --version
printf "\n\tTERRAFORM:\n"
terraform --version
printf "\n\tMINIKUBE:\n"
minikube version
printf "\n\tKUBECTL:\n"
kubectl version --client
printf "\n\tHELM:\n"
helm version -c
printf "\n\tEXIBE SE DISCO = 20G:\n"
df -h | grep /dev/xvda1
#liberando acesso externo
printf "\n\tAPLICANDO ULTIMAS CONFIGURAÇÕES:\n"
#sudo apt-get -y install jq > /dev/null
sh ~/environment/config-ubuntu/pacotes.sh
printf "\n\tMAVEN:\n"
mvn -version
printf "\n\tCONFIGURANDO FIREWALL:\n"
NOME_GRUPO_SEGURANCA=$(aws ec2 describe-security-groups | jq '.SecurityGroups[] | select(.GroupName | contains("cloud9")) | .GroupName' | tr -d \")
aws ec2 authorize-security-group-ingress --group-name $NOME_GRUPO_SEGURANCA --protocol tcp --port 0-65535 --cidr 0.0.0.0/0
#liberando acesso externo
printf "\n\tEXIBE SE AMBIENTE CLOUD9 ESTÁ COM FIREWALL LIBERADO (em caso de erro, executar: \"sh ~/environment/config-ubuntu/firewall_alow.sh\" :\n"
aws ec2 describe-security-groups --query 'SecurityGroups[?IpPermissions[?contains(IpRanges[].CidrIp, `0.0.0.0/0`)]].{GroupName: GroupName}'                                                       

source ~/.bash_profile
