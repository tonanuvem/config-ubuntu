aws iam create-role --role-name eksFiapClusterRole --assume-role-policy-document file://eksFiapClusterRole.yaml

aws iam create-role --role-name eksFiapWoker --assume-role-policy-document file://eksFiapWoker.yaml

aws eks --region us-east-1 update-kubeconfig --name eksfiap
