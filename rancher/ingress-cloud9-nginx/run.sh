#!/bin/bash

# https://rancher.com/docs/rancher/v2.x/en/installation/options/nginx/

../terraform output > ./output.txt

NODE_UM=$(grep -E ".*1=\d{" output.txt)
#

docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v ./nginx.conf:/etc/nginx/nginx.conf \
  nginx:alpine
