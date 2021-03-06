echo "Verificando as credenciais AWS (~/.aws/credentials) :"
aws sts get-caller-identity

# antes de iniciar, deve ser criada pela console a função "eksFiapClusterRole" e inserir a política "AmazonEKSClusterPolicy"
#aws iam create-role --role-name eksFiapClusterRole
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name eksFiapClusterRole
aws iam get-role --role-name eksFiapClusterRole

# antes de iniciar, deve ser criada pela console a função "eksFiapWoker" e inserir as políticas "AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy e AmazonEC2ContainerRegistryReadOnly"
#aws iam create-role --role-name eksFiapWoker --assume-role-policy-document file://eksFiapWorker.json
#aws iam create-role --role-name eksFiapWorker
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name eksFiapWoker
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy --role-name eksFiapWoker
#aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name eksFiapWoker
aws iam get-role --role-name eksFiapWorker

ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
echo $ACCOUNT
sed -i 's|497573848553|'$ACCOUNT'|' main.tf

terraform init
terraform plan
terraform apply -auto-approve

#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=
#export AWS_DEFAULT_REGION=us-east-1

aws eks --region us-east-1 update-kubeconfig --name eksfiap
# pré-reqs : credencias da aws : ~/.aws/credentials e ~/.kube/config
# nao funciona no Cloud9 : https://aws.amazon.com/pt/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/
# as credenciais sao inseridas no ~/.kube/config
# mas ao acessar o cluster aparece o erro: error: You must be logged in to the server (Unauthorized)
