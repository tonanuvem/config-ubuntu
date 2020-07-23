#!/bin/bash

# Arquitetura Alta Disponibilidade:
# https://rancher.com/docs/rancher/v2.x/en/installation/how-ha-works/

# Existem varias opcoes de LoadBalancer. Nesse LAB, usaremos NGINX pela simplicidade.
# https://rancher.com/docs/rancher/v2.x/en/installation/options/nginx/
# https://rancher.com/docs/rancher/v2.x/en/installation/options/nlb/

../terraform output > ./output.txt

NODE_UM=$(grep -E ".*1=\d{" output.txt)
#

docker run -d --restart=unless-stopped   -p 800:80 -p 8443:443   -v $(pwd):/etc/nginx/ nginx:alpine
