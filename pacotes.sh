#!/bin/bash

echo "Aguardando Cloud9 (geralmente 4 min): apt.systemd.daily update."
while [ "$(ps aux | grep -i apt | wc -l)" != "1" ]; do
  printf "."
  sleep 1
done
echo "Instalando pacotes."
uptime
sudo apt-get -y install jq maven build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev > /dev/null
