#!/bin/bash
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
cp config.yaml /etc/rancher/rke2/
systemctl start rke2-server.service
