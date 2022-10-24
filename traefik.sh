#!/bin/bash

# A Documentação do traefik pode ser encontrada no link 
# https://doc.traefik.io/traefik/providers/kubernetes-crd/

# Install Traefik Resource Definitions:
#kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

# Install RBAC for Traefik:
#kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v2.9/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml

kubectl apply -f https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/traefik-rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/traefik-ds.yaml
kubectl --namespace=kube-system get pods
