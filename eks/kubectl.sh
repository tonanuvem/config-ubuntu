docker run -ti -v ~/.aws/credentials:/root/.aws/credentials -v ~/.kube/config:/root/.kube.config/ --entrypoint /bin/sh tonanuvem/kubectl-aws-cli
