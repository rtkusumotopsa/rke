#!/bin/bash

# Serial 2022102701

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
systemctl enable rke2-agent.service
mkdir -p /etc/rancher/rke2/
cp -v config-agent.yaml /etc/rancher/rke2/config.yaml
echo -e "Execute: \n systemctl start rke2-agent.service"

