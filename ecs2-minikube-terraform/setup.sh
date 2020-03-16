#!/usr/bin/env bash

set -e

# Install system dependencies
pushd "/tmp"
yum update -y
yum install -y git jq
amazon-linux-extras install docker -y

# Setup Docker
service docker start
usermod -a -G docker ec2-user

# Setup python dependencies and test libraries
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install tornado numpy

# Host system directories needed for ES
mkdir -p /usr/share/elasticsearch/data/nodes
mkdir -p /mnt/data
chmod -R 777 /usr/share/elasticsearch/data
chmod -R 777 /mnt/data 

# Setup gitlab-ci
docker volume create gitlab_data
external_public_ip="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)"
echo "external_url 'http://$external_public_ip'" >> /tmp/gitlab.rb
chmod 777 /tmp/gitlab.rb
docker run -p 80:80 -p 443:443 -v gitlab_data:/var/opt/gitlab -v /tmp/gitlab.rb:/etc/gitlab/gitlab.rb -d gitlab/gitlab-ce
sleep 10

# Install gitlab-runner
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
curl -L --output /usr/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
chmod +x /usr/bin/gitlab-runner
gitlab-runner install --working-directory /home/gitlab-runner --user root
gitlab-runner start

# Install minikube and kubectl
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/bin/kubectl
kubectl version --short --client
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x ./minikube
mv ./minikube /usr/bin/minikube
minikube start --vm-driver=none || true
minikube delete

# TODO: Needs more investigation. Minikube fails for the first time
minikube start --vm-driver=none
