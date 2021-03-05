#!/bin/bash

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tMASTER NODE: configurando hostname\n\n"

echo ""
echo "   Aguardando configurações: "
sleep 10
export IP=$(terraform output Node_1_ip_externo)
while [ $(ssh -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "echo CONECTADO" | grep CONECTADO | wc -l) != '1' ]; do { printf .; sleep 1; } done
echo "   Conectado ao $IP, verificando ajustes: "
ssh -oStrictHostKeyChecking=no -i ~/environment/chave-fiap.pem ubuntu@$IP "while [ \$(ls /usr/local/bin/ | grep docker-compose | wc -l) != '1' ]; do { printf .; sleep 1; } done"

ssh -i "~/environment/chave-fiap.pem" ubuntu@$IP "sudo hostnamectl set-hostname master"
echo "   Configuração MASTER OK."
