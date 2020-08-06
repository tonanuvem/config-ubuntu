#!/bin/bash
echo "KEYPAIR - Chave  de seguranca será exibido a seguir, aguardar."
echo ""
ls -lh chave-fiap*
echo ""
echo "Copie e cole o nome da CHAVE exibido acima : " 
read NOME_CHAVE
NOME_PUB=${NOME_CHAVE%%.pem}
ssh-keygen -f $NOME_CHAVE -y > public_$NOME_PUB.pub
