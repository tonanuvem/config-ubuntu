terraform init; terraform plan; terraform apply -auto-approve
echo ""
echo " Iniciando configurações: "
echo ""
sh config-node1.sh
sh config-node2.sh
sh config-node3.sh
echo " Cluster iniciado e configurado"
