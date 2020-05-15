echo "O nome do grupo de seguranca será exibido a seguir, aguardar."
echo ""
aws ec2 describe-security-groups | grep GroupName
echo ""
echo "Copie e cole o nome do grupo de seguranca CLOUD9 exibido acima (começa com aws-cloud9-fiap): " 
read NOME_GRUPO_SEGURANCA
aws ec2 authorize-security-group-ingress --group-name $NOME_GRUPO_SEGURANCA --protocol tcp --port 0-65535 --cidr 0.0.0.0/0
