#!/bin/bash
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
#journalctl -u rke2-server -f


