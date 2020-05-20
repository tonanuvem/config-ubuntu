#!/bin/bash

echo "Aguardando Cloud9 : apt.systemd.daily update."
while [ \
  "$(ps aux | grep -i apt | wc -l)" != "1" \ ]; do
sleep 1 | echo "."
done
echo "Instalando pacotes."
sudo apt-get -y install jq maven build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev > /dev/null
