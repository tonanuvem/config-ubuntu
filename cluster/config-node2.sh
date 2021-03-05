#!/bin/bash

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tNODE 2: configurando hostname\n\n"

echo ""
echo "   Aguardando configurações: "
sleep 1
export IP=$(terraform output Node_2_ip_externo)
while [ $(ssh -q -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "echo CONECTADO" | grep CONECTADO | wc -l) != '1' ]; do { printf .; sleep 1; } done
echo "   Conectado ao $IP, verificando ajustes: "
ssh -o LogLevel=error -i ~/environment/chave-fiap.pem ubuntu@$IP "while [ \$(ls /usr/local/bin/ | grep docker-compose | wc -l) != '1' ]; do { printf .; sleep 1; } done"

ssh -o LogLevel=error -i "~/environment/chave-fiap.pem" ubuntu@$IP "sudo hostnamectl set-hostname node2"
echo "   Configuração NODE 2 OK."
