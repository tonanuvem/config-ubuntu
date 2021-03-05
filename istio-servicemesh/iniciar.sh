terraform init; terraform plan; terraform apply -auto-approve
echo ""
echo "   Aguardando configurações: "
sleep 10
export IP=$(terraform output ip_externo)
while [ $(ssh -q -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "echo CONECTADO" | grep CONECTADO | wc -l) != '1' ]; do { printf .; sleep 1; } done
echo "   Conectado ao $IP, verificando ajustes: "
ssh -o LogLevel=error -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "while [ \$(ls /usr/local/bin/ | grep minikube | wc -l) != '1' ]; do { printf .; sleep 1; } done"
echo "   Configuração OK."
