terraform init; terraform plan; terraform apply -auto-approve
echo ""
echo " Iniciando configurações: "
sh config-master.sh
sh config-node1.sh
sh config-node2.sh
sh config-node3.sh
echo ""
echo " Master e Nodes 1, 2, 3 iniciados e configurados"
