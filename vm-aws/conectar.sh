MASTER=$(~/environment/ip | awk -Fv '{ if ( !($1 ~  "None") && (/vm_0/) ) { print $1} }')
echo "Conectando.. IP = $MASTER"
ssh -o LogLevel=error -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ec2-user@$MASTER
