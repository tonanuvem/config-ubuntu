# conectar

IP=$(terraform output ip_externo)

echo "Conectando.. IP = $IP.."
ssh -q -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP
