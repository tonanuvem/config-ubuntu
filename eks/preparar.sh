aws iam create-role --role-name eksFiapClusterRole
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name eksFiapClusterRole

#aws iam create-role --role-name eksFiapWoker --assume-role-policy-document file://eksFiapWorker.json
aws iam create-role --role-name eksFiapWoker
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name eksFiapWoker
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy --role-name eksFiapWoker
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name eksFiapWoker



aws eks --region us-east-1 update-kubeconfig --name eksfiap
