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

# Verificando as versões instaladas e atualizar permissão docker:
cd ~
printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tVerificando as instações:\n\n"

printf "\n\tTERRAFORM:\n"
terraform --version
