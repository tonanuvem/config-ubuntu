#!/bin/bash

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
# https://github.com/infrastructure-as-code/docker-aws-cli/blob/master/aws.sh

echo "Cole suas credenciais da AWS, e digite ENTER:"
CRED=$(sed '/^$/q')

#read -d '' x <<EOF
echo "$CRED" > ./files/credentials

# docker run -ti --rm --name kubectl -v ~/.aws/:/root/.aws/ -v ~/.kube/:/root/.kube/ --entrypoint /bin/sh tonanuvem/kubectl-aws-cli

docker run -ti --rm --name kubectl -v $PWD/files/:/root/.aws --entrypoint /bin/sh -d tonanuvem/kubectl-aws-cli

#docker run -ti --rm --name kubectl \
#	-e "AWS_ACCESS_KEY_ID=${aws_access_key_id}" \
#	-e "AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}" \
#	-e "AWS_DEFAULT_REGION=us-east-1" \
#	--entrypoint /bin/sh -d tonanuvem/kubectl-aws-cli

docker exec -ti kubectl aws eks --region us-east-1 update-kubeconfig --name eksfiap
echo ""
echo "URL de acesso externo ao Cluster: "
docker exec -ti kubectl aws eks --region us-east-1 describe-cluster --name eksfiap --query "cluster.endpoint"
docker exec -ti kubectl /bin/sh
