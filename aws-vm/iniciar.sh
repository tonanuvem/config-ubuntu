terraform init; terraform plan; terraform apply -auto-approve
echo ""
echo "   Aguardando configurações: "
sleep 10
export IP=$(~/environment/ip | awk -Fv '{ if ( !($1 ~  "None") && (/vm_0/) ) { print $1} }')
while [ $(ssh -q -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ec2-user@$IP "echo CONECTADO" | grep CONECTADO | wc -l) != '1' ]; do { printf .; sleep 1; } done
echo "   Conectado ao $IP, verificando ajustes: "
#ssh  -o LogLevel=error -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ec2-user@$IP "while [ \$(ls /usr/local/bin/ | grep docker-compose | wc -l) != '1' ]; do { printf .; sleep 1; } done"
echo "   Configuração OK."
