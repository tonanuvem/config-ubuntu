# conectar

IP=$(terraform output ip_externo)

echo "Conectando.. IP = $IP..
ssh -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP
