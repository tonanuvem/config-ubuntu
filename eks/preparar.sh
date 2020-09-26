aws iam create-role --role-name eksFiapClusterRole --assume-role-policy-document file://eksFiapClusterRole.json

aws iam create-role --role-name eksFiapWoker --assume-role-policy-document file://eksFiapWoker.json

aws eks --region us-east-1 update-kubeconfig --name eksfiap
