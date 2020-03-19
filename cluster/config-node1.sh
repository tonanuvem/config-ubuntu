#!/bin/bash

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tNODE 1: configurando hostname\n\n"

sudo echo "hostname node1" > /etc/profile
sudo echo "export NICKNAME=node1" > /etc/profile
