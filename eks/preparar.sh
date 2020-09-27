echo "Verificando as credenciais AWS (~/.aws/credentials) :"
aws sts get-caller-identity

#aws iam create-role --role-name eksFiapClusterRole
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name eksFiapClusterRole
aws iam get-role --role-name eksFiapClusterRole

#aws iam create-role --role-name eksFiapWoker --assume-role-policy-document file://eksFiapWorker.json
#aws iam create-role --role-name eksFiapWorker
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name eksFiapWoker
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy --role-name eksFiapWoker
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name eksFiapWoker
aws iam get-role --role-name eksFiapWorker

ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
echo $ACCOUNT
sed -i 's|497573848553|'$ACCOUNT'|' eks-cluster.tf
sed -i 's|497573848553|'$ACCOUNT'|' eks-worker-nodes.tf

terraform init
terraform plan
terraform apply -auto-approve

#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=
#export AWS_DEFAULT_REGION=us-east-1

aws eks --region us-east-1 update-kubeconfig --name eksfiap
