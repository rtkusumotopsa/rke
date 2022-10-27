#!/bin/bash

# Serial: 2022102702

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
mkdir -p /etc/rancher/rke2
cp config.yaml /etc/rancher/rke2/
# sleep 10
# systemctl start rke2-server.service
