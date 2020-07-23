#!/bin/bash

# instalacao do provider RKE

curl -LO https://github.com/rancher/terraform-provider-rke/releases/download/v1.0.1/terraform-provider-rke_1.0.1_linux_amd64.zip && \
unzip terraform-provider-rke_1.0.1_linux_amd64.zip && \
chmod +x ./terraform-provider-rke_v1.0.1 && \
mkdir -p ~/.terraform.d/plugins/linux_amd64/ && \
mv ./terraform-provider-rke_v1.0.1 ~/.terraform.d/plugins/linux_amd64/terraform-provider-rke_v1.0.1
rm -rf ./terraform-provider-rke_*

# atualizando as credenciais da AWS
#ACCESS=$(cat ~/.aws/credentials | grep aws_access_key)
#SECRET=$(cat ~/.aws/credentials | grep aws_secret_access_key) 
#sed -i 's|aws_access_key = ""|'$ACCESS'|' terraform.tfvars
#sed -i 's|aws_secret_key = ""|'$SECRET'|' terraform.tfvars

# atualizando outras variaveis
#sed -i 's|# aws_region = ""|aws_region = "us-east-1"|' terraform.tfvars
#sed -i 's|# instance_type = ""|instance_type = "t2.medium"|' terraform.tfvars
#sed -i 's|# prefix = ""|prefix = "fiap"|' terraform.tfvars
