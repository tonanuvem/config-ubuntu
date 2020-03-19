#!/bin/bash

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tMASTER NODE: configurando hostname\n\n"

sudo echo "hostname master" > /etc/profile
sudo echo "export NICKNAME=master" > /etc/profile
