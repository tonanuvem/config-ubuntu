echo ""
echo "Os IPs das máquinas do Cluster serão exibidos a seguir, aguardar."
echo ""
aws ec2 describe-instances --query "Reservations[*].Instances[*].[PublicIpAddress, Tags[?Key=='Name'].Value|[0]]" --output text | grep -v None #| grep cluster
echo ""
echo "Copie e cole um dos IPs exibidos acimas : " 
read IP

echo "Conectando.. IP = $IP.."
ssh -o LogLevel=error -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP
