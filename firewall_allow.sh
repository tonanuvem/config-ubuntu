echo "O nome do grupo de seguranca será exibido a seguir, digite qualquer tecla para continuar."
read CONTINUAR
aws ec2 describe-security-groups | grep GroupName
echo "Copie e cole o nome do grupo de seguranca CLOUD9 exibido acima : " 
read NOME_GRUPO_SEGURANCA
aws ec2 authorize-security-group-ingress --group-name $NOME_GRUPO_SEGURANCA --protocol tcp --port 0-65535 --cidr 0.0.0.0/0
