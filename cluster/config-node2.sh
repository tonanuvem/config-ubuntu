#!/bin/bash

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tNODE 2: configurando hostname\n\n"

sudo echo "hostname node2" >> /etc/profile
sudo echo "export NICKNAME=node2" >> /etc/profile
