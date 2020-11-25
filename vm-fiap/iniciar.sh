terraform init; terraform plan; terraform apply -auto-approve
echo ""
echo "Aguardando configurações "
sleep 5
echo "."
export IP=$(terraform output ip_externo) 
echo $IP
ssh -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "while [ \$(ls /usr/local/bin/ | grep docker-compose | wc -l) != '1' ]; do { printf .; sleep 1; } done"
#ssh -i "~/environment/chave-fiap.pem" ubuntu@$IP "while [ $(ls /usr/local/bin/ | grep docker-compose | wc -l) != '1' ]; do { printf .; sleep 1; } done"
#ssh -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "while [ \$(dpkg -l | grep kubeadm | wc -l) != '1' ]; do { printf .; sleep 1; } done"
