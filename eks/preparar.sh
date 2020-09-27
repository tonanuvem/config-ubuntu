aws iam create-role --role-name eksFiapClusterRole
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name eksFiapClusterRole

#aws iam create-role --role-name eksFiapWoker --assume-role-policy-document file://eksFiapWorker.json
aws iam create-role --role-name eksFiapWoker
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name eksFiapWoker
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy --role-name eksFiapWoker
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name eksFiapWoker

ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
echo $ACCOUNT
sed -i 's|497573848553|'$ACCOUNT'|' eks-cluster.tf
sed -i 's|497573848553|'$ACCOUNT'|' eks-worker-nodes.tf

aws eks --region us-east-1 update-kubeconfig --name eksfia
