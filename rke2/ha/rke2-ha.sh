#!/bin/bash

# Serial: 2022102703

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
mkdir -p /etc/rancher/rke2
cp config.yaml /etc/rancher/rke2/
# sleep 10
echo "Execute para inicializar: systemctl start rke2-server.service"
