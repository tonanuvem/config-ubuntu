# conectar

# IP=$(~/environment/ip | awk -Fv '{ if ( !($1 ~  "None") && (/fiap_vm/) ) { print $1} }')

$(~/environment/ip | grep fiap_vm)

echo "Digitar o IP para conectar :"
read IP

echo "Conectando.. IP = $IP..
ssh -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP
