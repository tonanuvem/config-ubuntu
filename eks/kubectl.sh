# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
# https://github.com/infrastructure-as-code/docker-aws-cli/blob/master/aws.sh

echo "Copie e cole suas credenciais da AWS, e no final digite a palavra FIM (e aperte a tecla ENTER)"
cat >> ./files/credentials << FIM

# docker run -ti --rm --name kubectl -v ~/.aws/:/root/.aws/ -v ~/.kube/:/root/.kube/ --entrypoint /bin/sh tonanuvem/kubectl-aws-cli

docker run -ti --rm --name kubectl -v $PWD/files/:/root/.aws --entrypoint /bin/sh tonanuvem/kubectl-aws-cli

#docker run -ti --rm --name kubectl \
#	-e "AWS_ACCESS_KEY_ID=${aws_access_key_id}" \
#	-e "AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}" \
#	-e "AWS_DEFAULT_REGION=us-east-1" \
#	--entrypoint /bin/sh -d tonanuvem/kubectl-aws-cli

docker exec -ti kubectl aws eks --region us-east-1 update-kubeconfig --name eksfiap
docker exec -ti kubectl /bin/sh
