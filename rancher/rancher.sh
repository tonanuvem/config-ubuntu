#!/bin/bash

# instalacao do provider RKE

curl -LO https://github.com/rancher/terraform-provider-rke/releases/download/v1.0.1/terraform-provider-rke_1.0.1_linux_amd64.zip && \
unzip terraform-provider-rke_1.0.1_linux_amd64.zip && \
chmod +x ./terraform-provider-rke_v1.0.1 && \
mkdir -p ~/.terraform.d/plugins/linux_amd64/ && \
mv ./terraform-provider-rke_v1.0.1 ~/.terraform.d/plugins/linux_amd64/terraform-provider-rke_v1.0.1
rm -rf ./terraform-provider-rke_*
